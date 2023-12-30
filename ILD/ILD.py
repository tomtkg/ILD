import sys
import numpy as np

def ILD(H, M):
    I = M * np.eye(M)
    W = np.zeros((1, M))
    edgeW = W

    for _ in range(H):
        edgeW = np.tile(edgeW, (M, 1)) + np.repeat(I, edgeW.shape[0], axis=0)
        edgeW = np.unique(edgeW, axis=0)
        edgeW = edgeW [np.any(edgeW == 0, axis=1)]
        W = np.vstack((W + 1, edgeW))

    return W / (M * H)

if __name__ == '__main__':
    args = sys.argv
    H, M = int(args[1]), int(args[2])
    data = ILD(H, M)

    print('Decomposition parameter H =', H)
    print('Number of objectives M =', M)
    print('Total number of points N =', len(data))
    print(data)
