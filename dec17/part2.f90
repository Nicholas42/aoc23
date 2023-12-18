program part1
  use common
  implicit none

  integer, parameter :: step_turn = 4
  integer, parameter :: step_max = 10
  state = read_input(step_max)

  do while( find_next_moves(state, step_turn, step_max) > 0)
  end do

  print "(i0)", find_min_loss(state, step_turn, step_max)
end program part1

