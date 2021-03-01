Explore the Pipeline
===
Above the terminal to your left, you will see three new tabs:
  - **Staging**, which is running separate Storedog frontend and discounts services. Right now it is very similar to the "production" Storedog instance, but the discounts data will be different.
  - **Gogs**, which is the user interface to the git repository running in this lab. Feel free to log in and explore the discounts service codebase. The username is "labuser" and the password is "password".
  - **Drone**, which is the user interface to the Drone.io build system running in this lab. There isn't much to explore right now, but it will get more interesting when you kick off a new discounts service build in a minute. The login credentials are the same as those for Gogs.

It will take a few minutes for these services to come online. Feel free to read ahead to familiarize yourself with the activities in this lab.

Trigger a Build
---
To see this pipeline in action, you'll make a minor change to the discounts service code to trigger a deployment. 

1. Click on the **IDE** tab above the terminal and give the editor a minute to start up. 
2. In the file tree, expand `lab/discounts-service`. This is a clone of the discounts-service code stored in the local Gogs server. 
3. Open `lab/discounts-servcie/discount.py`{{open}} and scroll to the bottom of the file. After the last line in the file, add a comment such as `# I added new code!`.
4. The editor automatically saves files when they change.

Now that you have updated the discounts service code, you must push it to the repository to trigger a build. 

1. In the terminal, change directory to `discounts-service` with the command `cd /root/lab/discounts-service`{{execute}}.
2. Type `git diff`{{execute}} to confirm that you have added a new line to the file.
3. Type `git add discount.py`
4. Type `git commit -m "Added a comment"`
5. Type `git push origin master`. 

Gogs is configured with a Webhook that notifies Drone whenever a `push` event occurs. Drone immediately clones the affected repository and gets to work doing what it is configured to. To see this in action:
1. Click the **Drone** tab above the terminal.
2. If you haven't already, log in using the username "labuser" and the password "password"
3. Click on the spinning gear in the upper-right corner of the Repositories page.
4. On the left-hand side is a list of steps Drone is configured to execute on this repository, along with their status. On the right-hand side, you can see the detailed progress of past and current step. It will take a few minutes for the build and deployment to complete, so click around to get familiar with Drone