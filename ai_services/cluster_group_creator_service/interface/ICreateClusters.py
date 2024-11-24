from abc import abstractmethod


class ICreateClusters:

    @abstractmethod
    def create_clusters(self, w_id: str):
        pass
