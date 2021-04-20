In the terminal on the right, the Kubernetes deployment for this activity is being brought online. This may take up to 2 minutes. When the deployment is created, you will see the message `Provisioning Complete` in the terminal along with your Datadog login credentials. 

The Datadog Agent is run as a DaemonSet to ensure that the Agent is deployed on all nodes. Using Autodiscovery, Datadog is able to detect that the deployment uses Kubernetes and Docker, so Datadog will install the Kubernetes and Docker Integrations for you as data starts coming in. 

In the meantime, let’s explore the datadog.yaml and lotsofpods.yaml files for the deployment. The datadog.yaml file is the datadog agent configuration file, and the lotsofpods.yaml file defines the number and details of the pods that are being brought online.

1. Click `datadog.yaml`{{open}} to view the file in the editor on the right.

2. Scroll to line 33 and 34. `DD_KUBERNETES_POD_LABELS_AS_TAGS` is set to `true` under `env` for the datadog agent, which means the deployed containers will have custom tags assigned via the <a href="https://docs.datadoghq.com/getting_started/tagging/assigning_tags/?tab=containerizedenvironments#environment-variables" target="_blank">environment variable</a>.

3. Click `lotsofpods.yaml`{{open}} to view the file in the editor.

4. Scroll through the file and look for lines similar to lines 6 and 18. These lines define the tags for each pod. 

    As you can see, the tags add some scope, function, and ownership to the containers. The tag keys are `environment`, `office`, `team`, `role` and `color`.

5. To confirm the pods are running, click `count-pods`{{execute}}. Make sure that 50 pods are running. If not, wait and repeat this step. 

    Once all the pods are running, let's view the infrastructure in Datadog. 

6. In a new browser window/tab, use the login credentials provided in the terminal to log in to the <a href="https://app.datadoghq.com/account/login" target="_datadog">Datadog account/organization</a> that was created for you for this activity.

    Note: If the credentials are not displayed in the terminal, run the command `creds`{{execute}} in the terminal. 

7. Navigate to <a href="https://app.datadoghq.com/infrastructure/map" target="_datadog">**Infrastructure** > **Host Maps**</a>.

8. In the menu at the top, change **Hosts** to **Containers** and delete `availability-zone` from the **Group hosts by Tags** field.

9. Hover over the containers. In the bottom right, you should see that at least 50 containers are running in the deployment. 

    ![containers](taggingk8s/assets/containers-running.png)

10. Click one of the containers labeled `my-container-*` and view its tags. <p>Some of the tags are the custom tags assigned in the lotsofpods.yaml, while others are assigned by Datadog such as `host` or through integration inheritance such as `kube-container-name`.

Now that the containers are up and running, let’s start mapping the containers using the tags.