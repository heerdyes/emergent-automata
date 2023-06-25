def zerogrid(m,n):
  g=[]
  for i in range(m):
    row=[]
    for j in range(n):
      row.append(0);
    g.append(row)
  return g

def loadgrid(fn):
  with open(fn) as f:
    lns = [ln.strip() for ln in f.readlines()]
  grid=[]
  for ln in lns:
    grid.append([int(item) for item in ln.split()])
  return grid

# testing
if __name__=='__main__':
  g=loadgrid('zeroth.init')
  print(g)

