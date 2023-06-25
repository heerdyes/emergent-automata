''' row charlength validator '''
def chkrows(a,b,c):
  if a=='' or b=='' or c=='':
    raise Exception('parse error: 3 contiguous non-empty rows expected, found atleast 1 to be empty!')
  if len(a)!=3:
    raise Exception('parse error: [row1] 3 chars expected, found: '+len(a))
  if len(c)!=3:
    raise Exception('parse error: [row3] 3 chars expected, found: '+len(c))
  if len(b)<6:
    raise Exception('parse error: [row2] atleast 6 chars expected, found: '+len(b))

''' middle row post split transition validator '''
def chkarrow(xlr):
  if len(xlr)!=2:
    raise Exception('expected xxx -> y, found: ' + '->'.join(xlr))


''' rule parser fn '''
def rgrok(fn):
  rm = {}
  with open(fn) as f:
    lns = [ln.strip() for ln in f.readlines()]
  i = 0
  while i<len(lns):
    if lns[i]=='':
      i+=1
      continue
    m1, m2s, m3      = lns[i:i+3]
    chkrows(m1, m2s, m3)
    m2               = m2s[0:3]
    lr               = m2s.split('->')
    chkarrow(lr)
    nxt              = lr[1].strip()
    rm[(m1, m2, m3)] = nxt
    i += 3
  return rm

# optional flow
if __name__=='__main__':
  gm=rgrok('zeroth.rules')
  print(gm)

