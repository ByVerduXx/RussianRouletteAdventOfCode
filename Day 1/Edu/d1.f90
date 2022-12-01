program prueba
  integer :: eof = 0, sum = 0, x, aux
  integer, dimension(3) :: max = 0
  character(10) :: str

  do while (eof == 0)
    ! read a line
    read(*, '(A)', IOSTAT=eof) str
    ! print*, str

    ! convert to integer if possible and add to sum
    if ((str /= '') .and. (eof == 0)) then
      read(str, *) x
      ! print*, x
      sum = sum + x
    
    ! if not possible, check for max
    else
      do i = 1, 3
        if (sum > max(i)) then
          aux = sum
          sum = max(i)
          max(i) = aux
        end if
      end do
      sum = 0
    end if
  end do

  ! print max
  do i = 1, 3, 1
    print *, max(i)
  end do

  ! print max sum
  print *, max(1) + max(2) + max(3)
end program prueba
