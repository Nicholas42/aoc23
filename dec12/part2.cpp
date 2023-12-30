#include <algorithm>
#include <charconv>
#include <chrono>
#include <cstddef>
#include <execution>
#include <fstream>
#include <functional>
#include <iostream>
#include <iterator>
#include <numeric>
#include <span>
#include <string>
#include <string_view>
#include <system_error>
#include <vector>

using namespace std::literals;

enum class Spring : char {
  Good = '.',
  Bad = '#',
  Ugly = '?',
};

constexpr auto MultiplicationFactor = 5ul;

template <class T>
auto remove_prefix(std::span<T> &span, size_t size) -> std::span<T> {
  const auto removed = span.first(size);
  span = span.last(span.size() - size);
  return removed;
}

struct RemainingCount {
  size_t good{};
  size_t bad{};
  size_t ugly{};

  size_t sizes{};

  auto operator<=>(const RemainingCount &other) const = default;

  auto can_be_fullfilled() const -> bool {
    return bad + ugly >= sizes && bad <= sizes;
  }

  auto is_done() const -> bool { return sizes == 0; }

  auto remove_spring(Spring spring) -> void {
    switch (spring) {
    case Spring::Good:
      good -= 1;
      break;
    case Spring::Bad:
      bad -= 1;
      break;
    case Spring::Ugly:
      ugly -= 1;
      break;
    }
  }

  auto remove_size(size_t size) -> void { sizes -= size; }
};

struct Problem {
  std::vector<size_t> sizes;
  std::vector<Spring> springs;
};

struct ProblemView {
  std::span<const size_t> sizes;
  std::span<const Spring> springs;
  RemainingCount remaining_count;

  explicit ProblemView(std::span<const size_t> sizes_,
                       std::span<const Spring> springs_)
      : sizes(sizes_), springs(springs_), remaining_count(count()) {}

  explicit ProblemView(const Problem &problem)
      : ProblemView(problem.sizes, problem.springs) {}

  auto pop_spring() -> Spring {
    auto result = springs.front();
    remaining_count.remove_spring(result);
    remove_prefix(springs, 1);
    return result;
  }

  auto extend_springs(size_t extra_length) {
    // DANGER AHEAD
    springs = std::span(springs.data(), springs.size() + extra_length);
    remaining_count = count();
  }

  auto pop_size() -> size_t {
    auto result = sizes.front();
    remaining_count.remove_size(result);
    remove_prefix(sizes, 1);
    return result;
  }

  auto drop_end_sizes(size_t index) -> std::span<const size_t> {
    auto result = sizes;
    sizes = remove_prefix(result, index);
    remaining_count.sizes =
        std::accumulate(sizes.begin(), sizes.end(), 0ul, std::plus<>{});

    return result;
  }

  auto count() const -> RemainingCount {
    auto result = RemainingCount{};

    for (const auto spring : springs) {
      switch (spring) {

      case Spring::Good:
        ++result.good;
        break;
      case Spring::Bad:
        ++result.bad;
        break;
      case Spring::Ugly:
        ++result.ugly;
        break;
      }
    }

    result.sizes =
        std::accumulate(sizes.begin(), sizes.end(), 0ul, std::plus<>{});

    return result;
  }
};

[[nodiscard]] auto count_solutions(ProblemView problem) -> size_t;

[[nodiscard]] auto read_line(std::string_view line) {
  auto problem = Problem{};
  const auto sep = line.find(' ');

  for (const char spring : line.substr(0, sep)) {
    switch (spring) {
    case '.':
      problem.springs.push_back(Spring::Good);
      break;
    case '#':
      problem.springs.push_back(Spring::Bad);
      break;
    case '?':
      problem.springs.push_back(Spring::Ugly);
      break;
    }
  }

  line.remove_prefix(sep);
  for (auto start = line.begin(); start != line.end();) {
    ++start;

    size_t size = 0;
    auto result = std::from_chars(start, line.end(), size);
    if (result.ec == std::error_code{}) {
      problem.sizes.push_back(size);
    }
    start = result.ptr;
  }

  return problem;
}

[[nodiscard]] auto read_file(std::string fname) -> std::vector<Problem> {
  auto result = std::vector<Problem>{};
  auto ifstream = std::ifstream{fname};
  auto buffer = ""s;

  while (std::getline(ifstream, buffer) && !buffer.empty()) {
    result.push_back(read_line(buffer));
  }

  return result;
}

[[nodiscard]] auto eat_bad(ProblemView &problem) -> bool {
  auto bad = problem.pop_size() - 1;
  if (problem.springs.size() < bad) {
    return false;
  }

  while (bad > 0) {
    --bad;
    const auto spring = problem.pop_spring();
    if (spring == Spring::Good) {
      return false;
    }
  }

  if (problem.springs.size() > 0) {
    const auto spring = problem.pop_spring();
    if (spring == Spring::Bad) {
      return false;
    }
  }

  return true;
}

[[nodiscard]] auto handle_bad(ProblemView problem) -> auto {
  if (!eat_bad(problem)) {
    return 0ul;
  }
  return count_solutions(problem);
}

[[nodiscard]] auto count_solutions(ProblemView problem) -> size_t {
  if (!problem.remaining_count.can_be_fullfilled()) {
    return 0;
  }

  if (problem.remaining_count.is_done()) {
    return 1;
  }

  const auto first_spring = problem.pop_spring();
  switch (first_spring) {
  case Spring::Good:
    return count_solutions(problem);
  case Spring::Bad:
    return handle_bad(problem);
  case Spring::Ugly:
    const auto bad = handle_bad(problem);
    const auto good = count_solutions(problem);

    return good + bad;
  }

  return 0;
}

[[nodiscard]] auto count_multiplication(ProblemView initial_problem,
                                        const ProblemView current_problem,
                                        size_t remaining_multiplications) {
  if (remaining_multiplications == 0) {
    return count_solutions(current_problem);
  }

  auto sum = 0ul;

  // good
  for (auto i = 0ul; i <= current_problem.sizes.size(); ++i) {
    auto prefix = current_problem;
    const auto remaining_sizes = prefix.drop_end_sizes(i);
    const auto postfix = ProblemView{remaining_sizes, initial_problem.springs};

    auto prefix_count = count_solutions(prefix);
    if (prefix_count > 0) {
      const auto post_fix_count = count_multiplication(
          initial_problem, postfix, remaining_multiplications - 1);
      sum += prefix_count * post_fix_count;
    }
  }

  // We have an underlying vector that is big enough for this and has Bad
  // springs at the correct places
  auto bad_problem = current_problem;
  bad_problem.extend_springs(initial_problem.springs.size() + 1);

  sum += count_multiplication(initial_problem, bad_problem,
                              remaining_multiplications - 1);

  return sum;
}

int counted = 0;

struct Result {
  size_t count{};
  std::chrono::steady_clock::duration time_elapsed{};
  long others_finished{};
  std::string problem;
};

[[nodiscard]] auto calculate_solution(Problem problem) -> size_t {
  problem.sizes.reserve(problem.sizes.size() * MultiplicationFactor);
  problem.springs.reserve(problem.springs.size() * MultiplicationFactor +
                          MultiplicationFactor - 1);

  // Save, we will not reallocate after this
  const auto initial_view = ProblemView(problem);

  for (auto i = 1ul; i < MultiplicationFactor; ++i) {
    std::ranges::copy(initial_view.sizes, std::back_inserter(problem.sizes));
    problem.springs.push_back(Spring::Bad);
    std::ranges::copy(initial_view.springs,
                      std::back_inserter(problem.springs));
  }

  const auto view_with_all_sizes =
      ProblemView{problem.sizes, initial_view.springs};

  const auto result = count_multiplication(initial_view, view_with_all_sizes,
                                           MultiplicationFactor - 1);
  return result;
}

auto main(int argc, char const *const *argv) -> int {
  if (argc < 2) {
    std::cerr << "Usage: " << argv[0] << " <input.txt>\n";
    return 1;
  }

  const auto problems = read_file(argv[1]);

  const auto result = std::transform_reduce(
      problems.begin(), problems.end(), 0ul, std::plus<>{},
      [](const auto &problem) { return calculate_solution(problem); });

  std::cout << result << "\n";
}
