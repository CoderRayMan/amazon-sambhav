from abc import abstractmethod


class ICreateClusters:

    @abstractmethod
    def create_clusters(self, g_id: str):
        pass
