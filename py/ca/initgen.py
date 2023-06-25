import random
import sys

def rndgen(fnm, m, n, p1):
  with open(fnm, 'w') as f:
    for i in range(m):
      for j in range(n):
        v = random.random()
        z = 1 if v<p1 else 0
        print('%d'%z, end='', file=f)
        if j<n-1:
          print(' ', end='', file=f)
      print('\n', end='', file=f)
    
if __name__ == '__main__':
  if len(sys.argv)!=5:
    raise Exception('3 args expected: initgen.py <filename> <rows> <cols> <prob(1)>')
  fnm  = sys.argv[1]
  rows = int(sys.argv[2])
  cols = int(sys.argv[3])
  pr1  = float(sys.argv[4])
  rndgen(fnm+'.init', rows, cols, pr1)

