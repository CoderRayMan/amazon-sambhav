from abc import abstractmethod


class IFetchData:

    @abstractmethod
    def fetch_orders_data(self, w_id: str):
        pass

    @abstractmethod
    def fetch_zips_data(self):
        pass
