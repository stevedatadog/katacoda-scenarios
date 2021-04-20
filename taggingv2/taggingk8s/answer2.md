### Answers

#### Using inherited tags
3) How many containers are in the `my-container` group? **49 containers**

&nbsp; 

![my-containers](taggingk8s/assets/groupby-kube-container-name.png)

&nbsp; 

#### Using custom tags
1) How many containers have no `environment` tag? **1 container** 
<p>   Which team(s) do they belong to? **dev**

&nbsp; 

![no-environment](taggingk8s/assets/no-environment-container.png)

&nbsp; 

2) Which office is running the most `production` containers? **nyc** 
<p>   How many containers are they running? **6 containers**

&nbsp; 

![productionbyoffice](taggingk8s/assets/production-office-groups.png)

&nbsp; 

3) How many roles are associated with the `qa` environment? **4 roles**
<p>   Which *role* is at the most offices? **web**

&nbsp; 

![qabyroleoffice](taggingk8s/assets/qa-role-office-groups.png)

&nbsp; 

#### Adding new tags to a deployment

1) Do you see the `owner` tag in the group by list? **No**

&nbsp; 

![noowner](taggingk8s/assets/no-owner-tag.png)

&nbsp; 

3) Do you see the `owner` tag in the group by list? **Yes**

&nbsp; 

![owner](taggingk8s/assets/owner-tag.png)

&nbsp; 

5) How many unique values for the `owner` tag are there? **2 values**

&nbsp; 

![groupbyowner](taggingk8s/assets/group-by-owner.png)

&nbsp; 