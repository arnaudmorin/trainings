# Roles
## Introduction
Roles in ansible are composed of multiples tasks that are executed together in order to configure a piece of software.
Usually, roles are included by playbooks.
The nice thing with roles is that they can be reused at different places, and thus it avoid copy/pasting of tasks.
Moreover, roles can take variables as input, so the tasks in the roles can do various things based on input parameters.

## Build your first role
In the previous lession, you built a playbook with tasks only.
Your job now will be to create 2 roles:
* one role for all tasks related to deploying the flask application
* one role for all tasks related to deploying nginx as a proxy
  * for this one, you must also use some variables as input parameters for both ports (80 and 8080 in the previous lessons)


# Cleanup
Once you're done, destroy the demo docker:

```
docker stop demo
```
