As part of my research for [PowerPUG!](https://github.com/TrimarcJake/PowerPUG), I’ve been trying to identify a consistent method or methods for identifying when Kerberos delegation actually occurs. But far as I can tell at the time of this writing, there is not a simple method to reliably identify all of the following:
1. Delegation type (Unconstrained, Constrained, Constrained with Protocol Transition, Resource-Based Constrained)
2. Delegated principal
3. Delegating principal
4. Delegation source machine
For PowerPUG!, I don’t *really* care about identifying the delegation type, but each type leaves different artifacts, so it’s probably worth figuring out in the process. This article will serve as a diary of the process. 
## What is Kerberos Delegation?

In short, Kerberos delegation allows one principal to connect to a service on behalf of another principal. The specifics of how this happens vary wildly depending on delegation type.

## Why Should I Care About It?

When a Principal 1 (let’s call them Benny) is acting as a delegate for Principal 2 (aka Melon), Benny gains all of Melon’s rights and privileges when interacting with one or more services in a 
