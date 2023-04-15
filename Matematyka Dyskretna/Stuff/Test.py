def determinant(matrix):
  if len(matrix) == 2 and len(matrix[0]) == 2:
    return matrix[0][0]*matrix[1][1] - matrix[0][1]*matrix[1][0]
  else:
    det = 0
    for c in range(len(matrix)):
      det += ((-1)**c)*matrix[0][c]*determinant(getMatrixMinor(matrix,0,c))
    return det

def getMatrixMinor(m,i,j):
  return [row[:j] + row[j+1:] for row in (m[:i]+m[i+1:])]


matrix = [[-8,2,-3], [4,10,1], [-7,-5,9]]
d=determinant(matrix)
print(d)