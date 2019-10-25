# Project 3 - Tapestry Algorithm


## Members
Milind Jayan - 8168 9617
Advait Ambeskar - 9615 9178

## Implementation
`mix run project3.exs numberOfNodes numberOfRequests`

## Constraints
>   **Input constraints:** 1 < numberOfNodes <= 10^4
>   The constraints have been set up purely because of the limits that have been tested upon. The algorithm must work beyond the constraints specified by the input for the total numberOfNodes.
>   **Input constaints:** 1 < numberOfRequests < numberOfNodes
>   The upper-bound on the numberOfRequests is due to the condition that each of the sent requests has to be unique

## What is working
- Static Overlay Network Generation (for 80% of the total nodes)
- Dynamic insertion of the nodes in the overlay network (20% of the total nodes)
- Tapestry algorithm to send messages from randomly selected source node to random destination nodes for number of requests as needed
- Calculating the hops needed for each node
- Displaying the maximum number of hops that any node in the network used to communicate

## Testing
Maximum number of nodes in a network = 10,000
(The test was limited to this number because pre-processing time is high. During the test of maximum nodes, the number of requests was kept at **100**. We did not test the networks of a larger size due to the total time it takes for execution of the project [30+ minutes.])

