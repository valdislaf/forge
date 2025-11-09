! Build (MSYS2/MinGW, x64):
!   del /q *.mod 2>nul
!   gfortran glfwindow3d.f90 -o glfwindow3d.exe -lglfw3 -lopengl32 -lgdi32 -luser32 -lkernel32
! If the linker can't find -lglfw3, add:
!   gfortran glfwindow3d.f90 -o glfwindow3d.exe -L"C:\msys64\mingw64\lib" -lglfw3 -lopengl32 -lgdi32 -luser32 -lkernel32

module cgl_types
  use iso_c_binding
  implicit none
  integer(c_int), parameter :: GL_COLOR_BUFFER_BIT = int(z'00004000', c_int)
  integer(c_int), parameter :: GL_DEPTH_BUFFER_BIT = int(z'00000100', c_int)
  integer(c_int), parameter :: GL_PROJECTION       = int(z'00001701', c_int)
  integer(c_int), parameter :: GL_MODELVIEW        = int(z'00001700', c_int)
  integer(c_int), parameter :: GL_LINES            = int(z'00000001', c_int)
  integer(c_int), parameter :: GL_DEPTH_TEST       = int(z'00000B71', c_int)
  integer(c_int), parameter :: GL_LEQUAL           = int(z'00000203', c_int)
end module

module glfw_bindings
  use iso_c_binding
  implicit none
  integer(c_int), parameter :: GLFW_PRESS   = 1_c_int
  integer(c_int), parameter :: GLFW_RELEASE = 0_c_int
  integer(c_int), parameter :: GLFW_KEY_W = 87_c_int
  integer(c_int), parameter :: GLFW_KEY_A = 65_c_int
  integer(c_int), parameter :: GLFW_KEY_S = 83_c_int
  integer(c_int), parameter :: GLFW_KEY_D = 68_c_int
  integer(c_int), parameter :: GLFW_KEY_SPACE      = 32_c_int
  integer(c_int), parameter :: GLFW_KEY_LEFT_SHIFT = 340_c_int
  integer(c_int), parameter :: GLFW_KEY_ESCAPE     = 256_c_int
  integer(c_int), parameter :: GLFW_CURSOR          = int(z'00033001', c_int)
  integer(c_int), parameter :: GLFW_CURSOR_DISABLED = int(z'00034003', c_int)
  interface
     function glfwInit() bind(C, name="glfwInit") result(ok)
       import :: c_int
       integer(c_int) :: ok
     end function
     subroutine glfwTerminate() bind(C, name="glfwTerminate")
     end subroutine
     function glfwCreateWindow(width, height, title, monitor, share) bind(C, name="glfwCreateWindow") result(window)
       import :: c_int, c_ptr, c_char
       integer(c_int), value :: width, height
       character(kind=c_char), dimension(*), intent(in) :: title
       type(c_ptr), value :: monitor
       type(c_ptr), value :: share
       type(c_ptr) :: window
     end function
     subroutine glfwMakeContextCurrent(window) bind(C, name="glfwMakeContextCurrent")
       import :: c_ptr
       type(c_ptr), value :: window
     end subroutine
     function glfwWindowShouldClose(window) bind(C, name="glfwWindowShouldClose") result(flag)
       import :: c_ptr, c_int
       type(c_ptr), value :: window
       integer(c_int) :: flag
     end function
     subroutine glfwSwapBuffers(window) bind(C, name="glfwSwapBuffers")
       import :: c_ptr
       type(c_ptr), value :: window
     end subroutine
     subroutine glfwPollEvents() bind(C, name="glfwPollEvents")
     end subroutine
     subroutine glfwGetFramebufferSize(window, width, height) bind(C, name="glfwGetFramebufferSize")
       import :: c_ptr, c_int
       type(c_ptr), value :: window
       integer(c_int) :: width, height
     end subroutine
     subroutine glfwSwapInterval(interval) bind(C, name="glfwSwapInterval")
       import :: c_int
       integer(c_int), value :: interval
     end subroutine
     function glfwGetTime() bind(C, name="glfwGetTime") result(t)
       import :: c_double
       real(c_double) :: t
     end function
     function glfwSetKeyCallback(window, cb) bind(C, name="glfwSetKeyCallback") result(prev)
       import :: c_ptr, c_funptr
       type(c_ptr),    value :: window
       type(c_funptr), value :: cb
       type(c_funptr)        :: prev
     end function
     subroutine glfwSetWindowShouldClose(window, value) bind(C, name="glfwSetWindowShouldClose")
       import :: c_ptr, c_int
       type(c_ptr),    value :: window
       integer(c_int), value :: value
     end subroutine
     function glfwGetKey(window, key) bind(C, name="glfwGetKey") result(state)
       import :: c_ptr, c_int
       type(c_ptr),    value :: window
       integer(c_int), value :: key
       integer(c_int)         :: state
     end function
     subroutine glfwGetCursorPos(window, xpos, ypos) bind(C, name="glfwGetCursorPos")
       import :: c_ptr, c_double
       type(c_ptr), value :: window
       real(c_double)     :: xpos, ypos
     end subroutine
     subroutine glfwSetInputMode(window, mode, value) bind(C, name="glfwSetInputMode")
       import :: c_ptr, c_int
       type(c_ptr),    value :: window
       integer(c_int), value :: mode, value
     end subroutine
     subroutine glfwSetCursorPos(window, xpos, ypos) bind(C, name="glfwSetCursorPos")
       import :: c_ptr, c_double
       type(c_ptr),    value :: window
       real(c_double), value :: xpos, ypos
     end subroutine
  end interface
end module

module gl_fixedfunc
  use iso_c_binding
  implicit none
  interface
     subroutine glViewport(x, y, w, h) bind(C, name="glViewport")
       import :: c_int
       integer(c_int), value :: x, y, w, h
     end subroutine
     subroutine glClearColor(r, g, b, a) bind(C, name="glClearColor")
       import :: c_float
       real(c_float), value :: r, g, b, a
     end subroutine
     subroutine glClear(mask) bind(C, name="glClear")
       import :: c_int
       integer(c_int), value :: mask
     end subroutine
     subroutine glMatrixMode(mode) bind(C, name="glMatrixMode")
       import :: c_int
       integer(c_int), value :: mode
     end subroutine
     subroutine glLoadIdentity() bind(C, name="glLoadIdentity")
     end subroutine
     subroutine glFrustum(l, r, b, t, n, f) bind(C, name="glFrustum")
       import :: c_double
       real(c_double), value :: l, r, b, t, n, f
     end subroutine
     subroutine glTranslatef(x, y, z) bind(C, name="glTranslatef")
       import :: c_float
       real(c_float), value :: x, y, z
     end subroutine
     subroutine glRotatef(a, x, y, z) bind(C, name="glRotatef")
       import :: c_float
       real(c_float), value :: a, x, y, z
     end subroutine
     subroutine glColor3f(r, g, b) bind(C, name="glColor3f")
       import :: c_float
       real(c_float), value :: r, g, b
     end subroutine
     subroutine glLineWidth(w) bind(C, name="glLineWidth")
       import :: c_float
       real(c_float), value :: w
     end subroutine
     subroutine glBegin(mode) bind(C, name="glBegin")
       import :: c_int
       integer(c_int), value :: mode
     end subroutine
     subroutine glEnd() bind(C, name="glEnd")
     end subroutine
     subroutine glVertex3f(x, y, z) bind(C, name="glVertex3f")
       import :: c_float
       real(c_float), value :: x, y, z
     end subroutine
     subroutine glEnable(cap) bind(C, name="glEnable")
       import :: c_int
       integer(c_int), value :: cap
     end subroutine
     subroutine glDepthFunc(fn) bind(C, name="glDepthFunc")
       import :: c_int
       integer(c_int), value :: fn
     end subroutine
     subroutine glClearDepth(d) bind(C, name="glClearDepth")
       import :: c_double
       real(c_double), value :: d
     end subroutine
	 subroutine glMultMatrixf(m) bind(C, name="glMultMatrixf")
    import :: c_float
    real(c_float), dimension(16), intent(in) :: m   ! column-major
  end subroutine
  end interface
end module

program glfwindow3d
  use iso_c_binding
  use cgl_types
  use glfw_bindings
  use gl_fixedfunc
  implicit none

  character(kind=c_char), parameter :: title(*) = &
       [ character(kind=c_char) :: 'O','p','e','n','G','L',' ','3','D', c_null_char ]

  type(c_ptr)     :: win
  integer(c_int)  :: ok, fw, fh
  real(c_double)  :: t_now, t_prev, t_rot0, dt
  real(c_float)   :: angle
  type(c_funptr)  :: prev_cb

  ! camera (C#-style defaults)
  real(c_float)  :: camPos(3)   = [1.5_c_float, 1.0_c_float, 11.5_c_float]
  real(c_float)  :: camFront(3) = [0.0_c_float, 0.0_c_float,-1.0_c_float]
  real(c_float)  :: camUp(3)    = [0.0_c_float, 1.0_c_float, 0.0_c_float]
  real(c_float)  :: yaw   =   0.0_c_float
  real(c_float)  :: pitch =   0.0_c_float
  real(c_float), parameter :: mouseSensitivity = 0.1_c_float
  real(c_float), parameter :: moveSpeed        = 4.52_c_float
  logical        :: firstMouse = .true.
  real(c_double) :: lastX = 400.0d0, lastY = 300.0d0

  ! init
  ok = glfwInit(); if (ok == 0_c_int) stop "glfwInit failed"
  win = glfwCreateWindow(800_c_int, 600_c_int, title, c_null_ptr, c_null_ptr)
  if (.not. c_associated(win)) then
     call glfwTerminate(); stop "glfwCreateWindow failed"
  end if
  call glfwMakeContextCurrent(win)
  call glfwSwapInterval(1_c_int)
  call glfwSetInputMode(win, GLFW_CURSOR, GLFW_CURSOR_DISABLED)
  call glfwSetCursorPos(win, 400.0d0, 300.0d0)
  call update_camera_vectors()

  prev_cb = glfwSetKeyCallback(win, c_funloc(on_key))

  call glEnable(GL_DEPTH_TEST)
  call glDepthFunc(GL_LEQUAL)
  call glClearDepth(1.0d0)

  t_prev = glfwGetTime()
  t_rot0 = t_prev
  angle  = 0.0_c_float

  do while (glfwWindowShouldClose(win) == 0_c_int)
     t_now = glfwGetTime()
     dt    = max(1.0d-6, t_now - t_prev)
     t_prev = t_now

     call process_mouse(win)
     call process_keyboard(win, real(dt, c_float))

     call glfwGetFramebufferSize(win, fw, fh)
     if (fw <= 0_c_int .or. fh <= 0_c_int) then
        fw = 1_c_int; fh = 1_c_int
     end if

     call glViewport(0_c_int, 0_c_int, fw, fh)
     call glClearColor(0.0_c_float, 0.0_c_float, 0.0_c_float, 1.0_c_float)
     call glClear(ior(GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT))

     call glMatrixMode(GL_PROJECTION); call glLoadIdentity()
     call set_perspective(60.0d0, dble(fw)/dble(fh), 0.1d0, 100.0d0)

     call glMatrixMode(GL_MODELVIEW); call glLoadIdentity()
     call apply_view()

     angle = 45.0_c_float * real(t_now - t_rot0, c_float)
     call glRotatef(angle,             0.0_c_float, 1.0_c_float, 0.0_c_float)
     call glRotatef(0.6_c_float*angle, 1.0_c_float, 0.0_c_float, 0.0_c_float)

     call glColor3f(1.0_c_float, 1.0_c_float, 1.0_c_float)
     call glLineWidth(1.0_c_float)
     call draw_wire_cube(1.0_c_float)

     call glfwSwapBuffers(win)
     call glfwPollEvents()
  end do

  call glfwTerminate()

contains
  subroutine normalize3(v)
    real(c_float) :: v(3)
    real(c_float) :: n
    n = sqrt( max(1.0e-20_c_float, v(1)*v(1)+v(2)*v(2)+v(3)*v(3)) )
    v = v / n
  end subroutine

  function cross3(a,b) result(c)
    real(c_float), intent(in) :: a(3), b(3)
    real(c_float) :: c(3)
    c(1) = a(2)*b(3) - a(3)*b(2)
    c(2) = a(3)*b(1) - a(1)*b(3)
    c(3) = a(1)*b(2) - a(2)*b(1)
  end function

  subroutine update_camera_vectors()
	  real(c_double) :: cy, sy, cp, sp, yrad, prad
	  yrad = dble(yaw  )*3.141592653589793d0/180.0d0
	  prad = dble(pitch)*3.141592653589793d0/180.0d0
	  cy = cos(yrad);  sy = sin(yrad)
	  cp = cos(prad);  sp = sin(prad)

	  ! было:
	  ! camFront = [ real(cy*cp, c_float), real(sp, c_float), real(sy*cp, c_float) ]

	  ! стало (–Z при yaw=0):
	  camFront = [ real( sy*cp, c_float),  &
				   real( sp    , c_float), &
				   real(-cy*cp , c_float) ]

	  call normalize3(camFront)

	  block
		real(c_float) :: right(3)
		right = cross3(camFront, [0.0_c_float, 1.0_c_float, 0.0_c_float]); call normalize3(right)
		camUp = cross3(right, camFront); call normalize3(camUp)
	  end block
	end subroutine


  subroutine process_mouse(win)
    type(c_ptr), value :: win
    real(c_double) :: xpos, ypos
    real(c_float)  :: dx, dy
    call glfwGetCursorPos(win, xpos, ypos)
    if (firstMouse) then
       lastX = xpos; lastY = ypos; firstMouse = .false.; return
    end if
    dx = real(xpos - lastX, c_float)
    dy = real(lastY - ypos, c_float)
    lastX = xpos; lastY = ypos
    dx = dx * mouseSensitivity
    dy = dy * mouseSensitivity
    yaw   = yaw   + dx
    pitch = pitch + dy
    if (pitch >  89.0_c_float) pitch =  89.0_c_float
    if (pitch < -89.0_c_float) pitch = -89.0_c_float
    call update_camera_vectors()
    call glfwSetCursorPos(win, 400.0d0, 300.0d0)
    lastX = 400.0d0; lastY = 300.0d0
  end subroutine

	subroutine process_keyboard(win, dt)
	  type(c_ptr),  value :: win
	  real(c_float), value :: dt
	  real(c_float) :: velocity, right(3), speedNow

	  speedNow = moveSpeed
	  if (glfwGetKey(win, GLFW_KEY_LEFT_SHIFT) == GLFW_PRESS) speedNow = moveSpeed * 2.0_c_float
	  velocity = speedNow * dt

	  ! Правильный "right": орт под (camFront × camUp)
	  right = cross3(camFront, camUp)
	  call normalize3(right)

	  ! Движение: W/S – вперёд/назад вдоль взгляда; A/D – чистый стрейф
	  if (glfwGetKey(win, GLFW_KEY_W) == GLFW_PRESS) camPos = camPos + velocity*camFront
	  if (glfwGetKey(win, GLFW_KEY_S) == GLFW_PRESS) camPos = camPos - velocity*camFront
	  if (glfwGetKey(win, GLFW_KEY_A) == GLFW_PRESS) camPos = camPos - velocity*right
	  if (glfwGetKey(win, GLFW_KEY_D) == GLFW_PRESS) camPos = camPos + velocity*right

	  if (glfwGetKey(win, GLFW_KEY_SPACE) == GLFW_PRESS) camPos = camPos + velocity*camUp
	end subroutine


	subroutine apply_view()
	  real(c_float) :: f(3), r(3), u(3)
	  real(c_float) :: m(16)

	  ! Ортонормированный базис камеры:
	  f = camFront; call normalize3(f)              ! forward (в OpenGL в матрице используем -f)
	  r = cross3(f, camUp); call normalize3(r)      ! right
	  u = cross3(r, f);  call normalize3(u)         ! up (пересчёт для ортогональности)

	  ! Column-major 4x4 view matrix (классический lookAt):
	  m = [ r(1),  u(1),  -f(1),  0.0_c_float,  &
			r(2),  u(2),  -f(2),  0.0_c_float,  &
			r(3),  u(3),  -f(3),  0.0_c_float,  &
		   - (r(1)*camPos(1) + r(2)*camPos(2) + r(3)*camPos(3)),  &
		   - (u(1)*camPos(1) + u(2)*camPos(2) + u(3)*camPos(3)),  &
			  (f(1)*camPos(1) + f(2)*camPos(2) + f(3)*camPos(3)),  &
			 1.0_c_float ]

	  call glMultMatrixf(m)
	end subroutine




  subroutine set_perspective(fov_deg, aspect, znear, zfar)
    real(c_double), value :: fov_deg, aspect, znear, zfar
    real(c_double)        :: f, t, r
    f = tan( (fov_deg*3.141592653589793d0/180.0d0) / 2.0d0 )
    t = znear * f
    r = t * aspect
    call glFrustum(-r, r, -t, t, znear, zfar)
  end subroutine

  subroutine draw_wire_cube(size)
    real(c_float), value :: size
    real(c_float)        :: s
    s = size * 0.5_c_float
    call glBegin(GL_LINES)
      call v(-s,-s,-s); call v( s,-s,-s)
      call v( s,-s,-s); call v( s, s,-s)
      call v( s, s,-s); call v(-s, s,-s)
      call v(-s, s,-s); call v(-s,-s,-s)
      call v(-s,-s, s); call v( s,-s, s)
      call v( s,-s, s); call v( s, s, s)
      call v( s, s, s); call v(-s, s, s)
      call v(-s, s, s); call v(-s,-s, s)
      call v(-s,-s,-s); call v(-s,-s, s)
      call v( s,-s,-s); call v( s,-s, s)
      call v( s, s,-s); call v( s, s, s)
      call v(-s, s,-s); call v(-s, s, s)
    call glEnd()
  end subroutine

  subroutine v(x, y, z)
    real(c_float), value :: x, y, z
    call glVertex3f(x, y, z)
  end subroutine

  subroutine on_key(window, key, scancode, action, mods) bind(C)
    type(c_ptr),    value :: window
    integer(c_int), value :: key, scancode, action, mods
    if (key == GLFW_KEY_ESCAPE .and. action == GLFW_PRESS) then
       call glfwSetWindowShouldClose(window, 1_c_int)
    end if
  end subroutine
end program
