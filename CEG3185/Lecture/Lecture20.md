# Lecture 20

## Autonomous Systems (AS)
* An AS is a set of <u> routers and networks </u> managed by single organization.
* An AS consists of a group of routers exchanging information via a common routing protocol.
* An AS is a connected network

## Routing Protocols
1. Interior Router Protocol (IRP): RIP, OSPF
2. Exterior Router Protocol (ERP): BGP

### Routing Information Protocol (RIP) - Distance Vector Routing
* Mechanism
    1. Each node (router or host) exchange  information with **neighbors**. Neighbors are both directly connected to same network.
    2. Node maintains vector of **link costs** for each *directly attached network* and **distance** and **next-hop** vectors for each  *destination*.
* Property
    1. Requires transmission of lots of information by each router
    2. Changes take long time to propagate
* Details
    * Partitions participants into **active** and **passive** machines. Active ones advertises their routes to others; passive ones listen to RIP message and use them to update their routing table, but don’t advertise.
    * ONLY a router can run RIP in active mode, a host MUST use passive mode.
    * A router broadcast a routing update **every 30 seconds**.
    * RIP uses **hop count** metric to measure distance




### Open Shortest Path First (OSPF) - Link State Routing
* Mechanism
    1. When router initialized, it determines link cost on each interface
    2. Advertises set of link costs to **all other routers** in topology (not just neighboring routers).
    3. From then on, monitor link costs. If change, router advertises new set of link costs
* Propery
    1. Each router can construct topology of entire configuration by calculating shortest path to each destination network and constructing routing table.
* Details
    * Topology stored as directed graph


### Border Gateway Protocol (BGP) - Path Vector
Note: Link-state and distance-vector not effective for exterior router protocol.

* Mechanism
    1. To dispatch with routing metrics and simply  provide information about which networks can be reached by a given router and ASs crossed to get there.
    2. Does not include a distance or cost estimate.
* Details
    * For use with TCP/IP internets
    * Messages sent over **TCP connections**: `open`, `update`, `keep-alive`, `notification`.

        |Message Type|Usage
        |---|---
        |open|Used to open a neighbor relationship with another router.
        |update|Used to transimit information about a single route or list multiple routes to be withdrawn.
        |keep-alive|Used to acknowledge an `open` message and periodically confirm the neighbor relationship.
        |notification|Send when an error condition is detected.
    * Procedures
        * Neighbor acquisition
            * Two routers are considered to be neighbors if they are attached to the same network.
            * Neighbor acquisition occurs when two neighboring routers in different autonomous systems agree to exchange routing information regularly.
            * One router sends a request message (`open` message) to the other, which may either accept (`keep-alive` message) or refuse the other.
        * Neighbor reachability
            * Once a neighbor relationship is established, the neighbor reachability procedure is used to maintain the relationship.
            * The two routers periodically issue `keep-alive` messages to each other.
        * Network reachability
            * Each router maintains a database of the networks that it can reach and the preferred route for reaching each network.
            * Whenever a change is made to this database, the router issues a `update` message that is broadcast to all other routers implementing BGP.
