from abc import abstractmethod


class IRouteOptimize:

    @abstractmethod
    def optimize_route(self, c_id: str):
        pass
