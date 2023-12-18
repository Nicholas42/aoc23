module common
  implicit none

  type :: t_state
    integer :: width, height
    integer, allocatable :: ops(:, :, :, :)
    integer, allocatable :: field(:, :)
  end type

  type(t_state) :: state

  integer, parameter :: step_min = 1

  ! Fake direction enum
  integer, parameter :: DirectionStart = 1
  integer, parameter :: North = 1
  integer, parameter :: East = 2
  integer, parameter :: West = 3
  integer, parameter :: South = 4
  integer, parameter :: DirectionEnd = 4

contains

  function movx(direction, x) result (new_x)
    integer, intent(in) :: direction, x
    integer :: new_x

    select case(direction)
    case (North)
      new_x = x
    case (East)
      new_x = x + 1
    case (South)
      new_x = x
    case (West)
      new_x = x - 1
    end select
  end function movx

  function movy(direction, y) result (new_y)
    integer, intent(in) :: direction, y
    integer :: new_y

    new_y = movx(turn_left(direction), y)
  end function movy

  function turn_right(direction) result(out_dir)
    integer, intent(in) :: direction
    integer :: out_dir

    select case(direction)
    case (North)
      out_dir = East
    case (East)
      out_dir = South
    case (South)
      out_dir = West
    case (West)
      out_dir = North
    end select
  end function turn_right

  function turn_left(direction) result(out_dir)
    integer, intent(in) :: direction
    integer :: out_dir

    out_dir = 5 - turn_right(direction)
  end function turn_left

  function read_input(step_max) result(state)
    integer, intent(in) :: step_max
    character(len=256) :: char_field(256)
    integer :: ios, x, y, step, dir
    integer, parameter :: input_file_unit = 42
    type(t_state) :: state

    open(unit=input_file_unit, file='input.txt', iostat=ios)
    if ( ios /= 0 ) stop "Error opening input"

    state%height = 0

    do
      read(input_file_unit, '(A)', iostat=ios) char_field(state%height + 1)
      if (ios /= 0) exit
      state%height = state%height + 1
    end do
    close(input_file_unit)

    state%width = len_trim(char_field(1))

    allocate(state%ops(0:state%width - 1, 0:state%height - 1, DirectionStart:DirectionEnd, step_min:step_max))
    allocate(state%field(0:state%width - 1, 0:state%height - 1))

    do y = 0, state%height - 1
      do x = 0, state%width - 1
        state%field(x, y) = ICHAR(char_field(y + 1)(x + 1:x + 1)) - ICHAR('0')
        do dir = DirectionStart, DirectionEnd
          do step = step_min, step_max
            state%ops(x, y, dir, step) = -1
          end do
        end do
      end do
    end do

    state%ops(1, 0, East, step_min) = state%field(1, 0)
    state%ops(0, 1, South, step_min) = state%field(0, 1)
  end function read_input

  function do_step(state, x, y, dir, step, loss) result(changed)
    type(t_state), intent(inout) :: state
    integer, intent(in) :: x, y, dir, step, loss
    integer :: new_loss, old_loss, changed

    changed = 0

    if ((x >= 0) .and. (x < state%width) .and. (y >= 0) .and. (y < state%height)) then
      new_loss = loss + state%field(x, y)
      old_loss = state%ops(x, y, dir, step)
      if ((new_loss < old_loss) .or. old_loss < 0) then
        state%ops(x, y, dir, step) = new_loss
        changed = 1
      end if
    end if
  end function do_step

  function find_min_loss(state, step_min, step_max) result(min_loss)
    type(t_state), intent(in) :: state
    integer, intent(in) :: step_min, step_max
    integer step, dir, loss, min_loss

    min_loss = -1

    do step = step_min, step_max
      do dir = DirectionStart, DirectionEnd
        loss = state%ops(state%width - 1, state%height - 1, dir, step)
        if (min_loss < 0 .or. (loss > 0 .and. min_loss > loss)) then
          min_loss = loss
        end if
      end do
    end do
  end function find_min_loss


  function find_next_moves(state, step_turn, step_max) result(changed)
    type(t_state), intent(inout) :: state
    integer, intent(in) :: step_turn, step_max
    integer :: x, y, dir, step, changed

    changed = 0

    do x = 0, state%width - 1
      do y = 0, state%height - 1
        do dir = DirectionStart, DirectionEnd
          do step = step_min, step_max
            changed = changed + find_next_move(state, x, y, dir, step, step_turn, step_max)
          end do
        end do
      end do
    end do
  end function find_next_moves

  function find_next_move(state, x, y, dir, step, step_turn, step_max) result(changed)
    type(t_state), intent(inout) :: state
    integer, intent(in) :: x, y, dir, step, step_turn, step_max
    integer :: cur_loss, new_dir, changed
    cur_loss = state%ops(x, y, dir, step)
    changed = 0

    if (cur_loss < 0) then
      return
    end if

    if (step < step_max) then
      changed = changed + do_step(state, movx(dir, x), movy(dir, y), dir, step + 1, cur_loss)
    end if

    if (step >= step_turn) then
      new_dir = turn_right(dir)
      changed = changed + do_step(state, movx(new_dir, x), movy(new_dir, y), new_dir, step_min, cur_loss)

      new_dir = turn_left(dir)
      changed = changed + do_step(state, movx(new_dir, x), movy(new_dir, y), new_dir, step_min, cur_loss)
    end if
  end function find_next_move

end module common
