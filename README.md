
## Dependency injection using repository pattern in this Assignment.
  
- So to fetch data we have three sources remote, local (core data) and json file.
- To achieve this requirement I have implemented repository which will use two instance of service class one for remote and another one for local data.
- These service classes must conform to service protocols
- Then repository itself conform to repository protocol which will first call remote service if that failed then call the local service.
- In local service I have handled for empty array. If app is opened first time and there is no data in Core Data then it will fetch from json file from bundle resource and return data accordingly.


