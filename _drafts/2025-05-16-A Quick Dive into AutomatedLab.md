While building [BlueTuxedo](https://github.com/jakehildreth/BlueTuxedo) (BT) in 2023, I was fortunate enough to work closely with [Jim Sykora](https://www.adminsdholder.com). In support of the project, Jim built out a small two-domain forest in his homelab for us to share. He would set up some weird ADI DNS stuff then I would update BT to detect that weird stuff. It worked really well.

After BT was released, I began using that little lab for everything. PowerPUG! was written almost 100% in that lab. Locksmith was updated in that lab. It's been really reliable.

But Jim is currently reconfiguring his homelab to be more... Jim-like. Multiple hosts, multiple architectures, multiple hypervisors, and multiple IaC methods. I'm super-excited to see what he builds, but this means the lab I've relied upon for years is no longer available.

Thankfully, [my employer](https://www.semperis.com) sent me a NUC last week! It's got an Intel Core i7 + 96GB RAM + 2TB m.2 drive. It flies. I'm going to use it to build out a new lab ASAP, and I'm going to use [AutomatedLab](https://automatedlab.org/en/latest/)!
## Who is AL?
>AutomatedLab (AL) enables you to setup test and lab environments on Hyper-v or Azure with multiple products or just a single VM in a very short time. There are only two requirements you need to make sure: You need the DVD ISO images and a Hyper-V host or an Azure subscription.

[Source](https://github.com/AutomatedLab/AutomatedLab/blob/develop/README.md)

AutomatedLab has been around for a while. The [AL repository](https://github.com/AutomatedLab/AutomatedLab) was created in 2016 and has received constant maintenance since then. 
