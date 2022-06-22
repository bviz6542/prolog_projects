# prolog_projects

## Real Time Elevator (with prolog)
- school project on 'Intelligent Informatic System' lecture
- you can test my code at https://swish.swi-prolog.org/
- I tried to implement 'real time elevator' in code, which is able to take real time calls from waiting users.
- query example: ?-runElevator([1,1,3,[4,5,6,7,5,4,1,3]],[2,1,4,[5,7,6,5,1,2,4]],[3,0,6,[7,6,5,1]])
- runElevator([elevator name, up or dowm, current floor, visiting lists], same, same)

- main ADTs I used: set, priority queue
- this code supports GUI. you can watch the elevators moving in real time.
