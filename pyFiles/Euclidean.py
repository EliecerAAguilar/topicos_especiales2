from math import pow, sqrt


class EuclideanD:
    def __init__(self, x1, x2, y1, y2):
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2

    def euclideanDistance(self, x1, y1, x2, y2):
        return sqrt(pow((x2-x1), 2)+pow((y2-y1), 2))
