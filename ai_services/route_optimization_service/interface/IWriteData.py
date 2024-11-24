from abc import abstractmethod


class IWriteData:

    @abstractmethod
    def write_data(self, data):
        pass
