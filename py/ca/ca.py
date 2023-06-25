from tkinter import *
from rulepars import rgrok
from utils import loadgrid,zerogrid
import sys

# globals
root  = None
c     = None
grid  = None
gridn = None
rows  = 0
cols  = 0
rects = []
t     = 0
sx    = 10
sy    = 10
mg    = 0
rm    = None
tgap  = 200
W, H  = 640, 640

# the ca evolution
def evolve():
  global grid,gridn,t
  for i in range(rows):
    for j in range(cols):
      c = grid[i][j]
      u = grid[i-1][j]
      l = grid[i][j-1]
      d = grid[(i+1)%rows][j]
      r = grid[i][(j+1)%cols]
      tr = 'x%dx'%u
      mr = '%d%d%d'%(l,c,r)
      br = 'x%dx'%d
      try:
        gridn[i][j] = int(rm[(tr, mr, br)])
      except KeyError as ke:
        # no change in cell if map has no corresponding transition
        gridn[i][j] = grid[i][j]
  # copy back next values to grid
  for i in range(rows):
    for j in range(cols):
      grid[i][j] = gridn[i][j]
  t += 1
  
# ca rectangle rendering
def rndr():
  global grid,gridn,t
  for j in range(cols):
    for i in range(rows):
      if grid[i][j]==0:
        c.itemconfigure(rects[i][j], fill='black')
      elif grid[i][j]==1:
        c.itemconfigure(rects[i][j], fill='white')
      else:
        raise Exception('kaboom! expected 0/1, found: '+grid[i][j])
  evolve()
  c.after(tgap, rndr)

# construct grid
def mkgrid():
  global rects
  for i in range(rows):
    rrow = []
    for j in range(cols):
      rrow.append(c.create_rectangle(mg+j*sx, mg+i*sy, mg+(j+1)*sx, mg+(i+1)*sy, fill='black'))
    rects.append(rrow)

def onkeypress(ke):
  global grid, gridn
  if ke.keycode==9:
    print('exiting...')
    raise SystemExit
  if ke.char==' ':
    print('resetting cellular automata')
    grid  = loadgrid(inif)
    gridn = zerogrid(rows, cols)


# flow
if __name__=='__main__':
  if len(sys.argv)!=3:
    raise Exception('usage: python3 ca.py <nm.rules> <nm.init>')
  rulf  = sys.argv[1]
  inif  = sys.argv[2]
  root  = Tk()
  root.geometry("640x640")
  c     = Canvas(root, width=W, height=H)
  c.bind_all("<Any-KeyPress>", onkeypress)
  c.pack()
  # grid-fu
  grid  = loadgrid(inif)
  # cell states: {0, 1}
  rows  = len(grid)
  cols  = len(grid[0])
  sx    = W/cols
  sy    = H/rows
  gridn = zerogrid(rows,cols)
  rm    = rgrok(rulf)
  # flow
  mkgrid()
  rndr()
  root.mainloop()

