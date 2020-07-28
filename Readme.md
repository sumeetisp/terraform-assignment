CMS Module

## Design
There are 2 modules, named frontend and DB,each for creating frontend with LB, ASG, and target group and other to create backend DB.

Frontend module creates a LB which is pointed to a target group on AWS. This target group is then attached to ASG.
Depending on the CPU usage the number of instances in the ASG can scale in or scale out. 
Frontend module is backed by db modules which has allocated storage and max allocated storage assigned.

These modules can be imported into other modules. For e.g import these modules into dev/main.tf or prod/main.tf and pass environment specific variable values.
