# Lab Introduction

<!-- TOC -->

- [Lab Introduction](#lab-introduction)
    - [Introduction to CloudForms](#introduction-to-cloudforms)
        - [Access the lab environment](#access-the-lab-environment)
    - [Verify Lab](#verify-lab)
        - [OpenStack Provider status](#openstack-provider-status)
        - [Red Hat Virtualization Provider status](#red-hat-virtualization-provider-status)
    - [CloudForms with Ansible batteries included](#cloudforms-with-ansible-batteries-included)
        - [Introduction to Ansible](#introduction-to-ansible)
        - [Make sure embedded Ansible role is enabled and running](#make-sure-embedded-ansible-role-is-enabled-and-running)
        - [Add a Git repository of Ansible Playbooks](#add-a-git-repository-of-ansible-playbooks)
    - [Build a Service Catalog to create and delete users](#build-a-service-catalog-to-create-and-delete-users)
        - [Create a Service Catalog for Ansible Playbooks](#create-a-service-catalog-for-ansible-playbooks)
        - [Create a Service Catalog Item for the Playbook](#create-a-service-catalog-item-for-the-playbook)
        - [Order the "create user" Service Catalog Item](#order-the-create-user-service-catalog-item)
        - [Monitor create user Playbook execution](#monitor-create-user-playbook-execution)
        - [Verify Playbook results](#verify-playbook-results)
    - [Build a Service Catalog to deploy Virtual Machines](#build-a-service-catalog-to-deploy-virtual-machines)
        - [Order the Virtual Machine Provisioning Service Catalog Item](#order-the-virtual-machine-provisioning-service-catalog-item)
        - [Monitor VM provisioning Playbook execution](#monitor-vm-provisioning-playbook-execution)
    - [Extend CloudForms builtin Capabilities](#extend-cloudforms-builtin-capabilities)
        - [Add a Git repository for Automate](#add-a-git-repository-for-automate)
        - [Verify Automate import](#verify-automate-import)
        - [Optimize the Dialog](#optimize-the-dialog)
        - [Update the Service Catalog Item](#update-the-service-catalog-item)
        - [Test the new Service Dialog](#test-the-new-service-dialog)
    - [Policies and Ansible](#policies-and-ansible)
        - [Creating the Service](#creating-the-service)
        - [Create a Service Catalog Item for the Policy Playbook](#create-a-service-catalog-item-for-the-policy-playbook)
        - [Creating Control Action](#creating-control-action)
        - [Create VM Control Policy](#create-vm-control-policy)
        - [Setting Event Assignment](#setting-event-assignment)
        - [Setting Control Action on Event](#setting-control-action-on-event)
        - [Creating and Assigning Policy Profile](#creating-and-assigning-policy-profile)
        - [Assign the policy profile](#assign-the-policy-profile)
        - [Testing the Policy Profile](#testing-the-policy-profile)
    - [Custom buttons calling Ansible Playbooks](#custom-buttons-calling-ansible-playbooks)
    - [Calling Ansible Playbooks from Automate](#calling-ansible-playbooks-from-automate)
    - [Advanced labs](#advanced-labs)
        - [Use the Self Service user Interface](#use-the-self-service-user-interface)
    - [Even more?](#even-more)

<!-- /TOC -->

## Introduction to CloudForms

[General introduction](../../common/index.md)

### Access the lab environment

Your workstation was configured to show a start page which has instructions on how to access the lab and this guide. Make sure you use the GUID provided on the front page in all of the following examples.

To access the Red Hat CloudForms Management Engine use the URL and credentials below:

        URL: https://cf46-<GUID>.rhpds.opentlc.com

        User: admin

        Password: r3dh4t1!

The ID &lt;GUID&gt; is unique to your lab environment and was presented to you on the browser start page! Replace the &lt;GUID&gt; with your lab specific value. For example, if your &lt;GUID&gt; would be "123a" the URL would become:

        https://cf46-123a.rhpds.opentlc.com

***Note:*** Your browser might give you a warning message about the used SSL Certificates. These warning messages can be accepted and are due to the fact that each lab deployed with new certificates on request.

## Verify Lab

### OpenStack Provider status

Let's first check the OpenStack Provider:

1. Navigate to ***Compute*** -> ***Clouds*** -> ***Providers***

    ![navigate to cloud providers](../../common/img/navigate-to-compute-clouds-providers.png)

1. You should see a tile icon labeled "OpenStack". Click on it.

    ![OpenStack provider tile icon](../../common/img/openstack-provider-tile.png)

1. Click on ***Authentication*** -> ***Re-check Authentication Status***

    ![re-check authentication](../../common/img/openstack-recheck-authentication.png)

    This will validate the credentials are correct, and it will also restart the provider specific background processes.

    Click the little arrow to reload the page.

    ![provider page reload](../../common/img/provider-reload.png)

After reloading the page, the provider tile should show a green check mark and the last update fields should report "less than a minute ago" or similar.

**Note:*** Don't worry if the last update does not refresh. As long as the provider icon is showing a green check box, you're good and can carry on with the lab.

### Red Hat Virtualization Provider status

Let's then check the RHV Provider:

1. Navigate to ***Compute*** -> ***Infrastructure*** -> ***Providers***

    ![navigate to cloud providers](../../common/img/navigate-to-compute-infrastructure-providers.png)

1. You should see a tile icon labeled "OpenStack". Click on it.

    ![OpenStack provider tile icon](../../common/img/rhv-provider-tile.png)

1. Click on ***Authentication*** -> ***Re-check Authentication Status***

    ![re-check authentication](../../common/img/rhv-recheck-authentication.png)

    This will validate the credentials are correct, and it will also restart the provider specific background processes.

    Click the little arrow to reload the page. 

    ![provider page reload](../../common/img/provider-reload.png)

After reloading the page, the provider tile should show a green check mark and the last update fields should report "less than a minute ago" or similar.

***Note:*** Don't worry if the last update does not refresh. As long as the provider icon is showing a green check box, you're good and can carry on with the lab.

## CloudForms with Ansible batteries included

***TODO: Replace this with a better example, we won't have vCenter in this lab***

This lab will guide you through the process of using the new embedded Ansible features of CloudForms 4.6.

### Introduction to Ansible

Today, every business is a digital business. Technology is your innovation engine, and delivering your applications faster helps you win. Historically, that required a lot of manual effort and complicated coordination. But today, there is Ansible - the simple, yet powerful IT automation engine that thousands of companies are using to drive complexity out of their environments and accelerate DevOps initiatives.

Red Hat CloudForms can integrate with IaaS, PaaS, public and private cloud and configuration management providers. Since version 4.2 of CloudForms, it can also integrate with Ansible Tower by Red Hat. The latest version which is 4.6, which has an improved "embedded Ansible" role which allows it to run Playbooks, manage credentials and retrieve Playbooks from a source control management like git.

This integration allows customers to build service catalogs from Ansible Playbooks to allow end users to easily browse, order and manage resources from Ansible. Ansible Playbooks can be used in Control Policies which can not only detect problems, but also automatically fix them. The user interface of CloudForms can be extended seamless with additional menus and buttons, which utilize Ansible Playbooks to perform user initiated tasks.

### Make sure embedded Ansible role is enabled and running

Before we start, we want to make sure the embedded Ansible role is enabled and running.

1. Log into your CloudForms Appliance

1. Click on your user name on the top right and click on ***Configuration***

    ![navigate to configuration](../../common/img/navigate-to-configuration.png)

1. Make sure the "Embedded Ansible" and the "Git Repositories Owner" Roles are enabled

    ![ansible role enabled](../../common/img/ansible-role-enabled.png)

1. Click on ***Diagnostics*** in the accordion on the left and click on the ***Workers*** tab

1. Make sure you can see a line indicating the "Embedded Ansible Worker" is in state "started"

    ***Note:*** The git role is not represented by a specific worker process.

    ![ansible worker started](../../common/img/ansible-worker-started.png)

### Add a Git repository of Ansible Playbooks

To be able to run Ansible Playbooks, they have to become available in CloudForms. Custom git repositories can be used as well as GitHub, GitLab or others. Other Source Control Management Systems like Subversion or Mercurial are planned for later versions.

1. Navigate to Automation, Ansible, Repositories.

    ![navigate to Ansible repositories](../../common/img/navigate-to-ansible-repo.png)

1. Click on ***Configuration***, ***Add New Repository***

    ![Add new repository](../../common/img/embedded-ansible-add-git-repository.png)

    ***Note:*** If the menu item "Add New Repository" is disabled, the Git Repository Role is not active.

1. Fill in the form.

    ***Name:*** Github

    ***Description:*** Example Playbooks

    ***URL:*** [https://github.com/cbolz/summit-fy19.git](https://github.com/cbolz/summit-fy19.git)

    ***SCM Update Options:*** check "Update on Launch"

    Update on Launch causes CloudForms to check for new Playbooks are updated Playbooks before a Playbook is executed.

    ![add a new repository](../../common/img/add-ansible-repository.png)

1. Click on ***Add*** to save the settings

***Note:*** It takes a few seconds for the action to complete. A pop up notification will inform you after the task was completed.

## Build a Service Catalog to create and delete users

In this lab we will use an Ansible Playbook to create a local user in CloudForms. This example will also demonstrate how we can define a retirement process as well. In CloudForms' understanding of complete life cycle management, every object has a provisioning and a retirement workflow.

### Create a Service Catalog for Ansible Playbooks

1. Navigate to ***Services*** -> ***Catalogs***

    ![navigate to service catalogs](../../common/img/navigate-to-service-catalog.png)

1. Click on ***Catalogs*** in the accordion on the left

1. Click on ***Configuration*** -> ***Add a New Catalog***

    ***Name:*** Ansible

    ***Description:*** Ansible Service Catalog Items

    ![create ansible catalog](../../common/img/create-ansible-catalog.png)

1. Click ***Add*** to save the new catalog

### Create a Service Catalog Item for the Playbook

1. Click on ***Catalog Items*** in the accordion on the left

    ![navigate to service catalog items](../../common/img/add-catalog-item.png)

1. Click on ***Configuration*** -> ***Add a New Catalog Item***

1. Select ***Ansible Playbook*** as "Catalog Item Type"

    ![add catalog item ansible Playbook](../../common/img/add-catalog-item-ansible-playbook.png)

    ***Note:*** Do not select Ansible Tower! We do not use Ansible Tower in this lab, but the embedded Ansible role of CloudForms.

1. Fill out the form to define the service catalog item:

    ***Name:*** Create User

    ***Description:*** Order this catalog item to create a new user

    ***Display in Catalog:*** Yes (check the box)

    ***Catalog:*** Ansible

    ***Repository:*** Github

    ***Playbook:*** create-user.yml

    ***Machine Credentials:*** CFME Default Credentials

    In the box ***Variables & Default Values*** we can enter the variables the Playbook requires:

    ***Variable:*** create_user_name

    ***Default:*** example

    Click on the little plus icon (+) to save the variable. Repeat the process for the second variable:

    ***Variable:*** create_user_password

    ***Default:*** secret

    Click on the little plus icon (+) to save the variable.

    ***Dialog:*** create new

    ***Dialog name:*** create-user

    ![create user service dialog](../../common/img/create-new-user-prov.png)

1. Click on the tab ***Retirement*** to switch to the second page of the form.

    ***Repository:*** Github

    ***Playbook:*** delete-user.yml

    ***Machine Credentials:*** CFME Default Credentials

    There are no variables needed for retirement and the ***Variables & Default Values*** can be left empty.

    ![create user service dialog retirement](../../common/img/create-new-user-retire.png)

1. Click on ***Add*** to save the catalog item

### Order the "create user" Service Catalog Item

To make sure everything works as expected, we want to test the Catalog Item we just created.

1. Navigate to the Service Catalog by clicking on ***Services*** -> ***Catalogs***

    ![navigate to service catalog](../../common/img/navigate-to-service-catalog.png)

1. Click on ***Service Catalog*** in the accordion on the left

1. Click on the Catalog Item you just created:

    ![navigate to service catalog](../../common/img/service-catalog-overview-create-user.png)

1. Click ***Order***

1. The default values in the form can be left alone. Optionally you can specify a different user name and password

    ![create user order form](../../common/img/create-user-order-form.png)

1. Click ***Submit***

    After clicking "Submit" you will be redirected to the Request Queue.

    ![request queue after ordering create user](../../common/img/request-queue-create-user.png)

### Monitor create user Playbook execution

When executing an Ansible Playbook with the embedded role in CloudForms, a "Service" object is automatically created. This service object gives us more details about the executed Playbook. It provides the output of the Playbook and it allows us to trigger retirement.

1. Navigate to ***Services*** -> ***My Services***

    ![navigate to my services](../../common/img/navigate-to-my-services.png)

1. You should see a new tile representing the Ansible Playbook Service you just ordered

    ***Note:*** If you don't see the tile yet, wait a minute and try again.

    ![create user service tile](../../common/img/my-service-create-user-tile.png)

1. After clicking on the icon, we can see more details about the service which was created

    ![create user service details](../../common/img/create-user-service-details.png)

    Since this Service does not create a Virtual Machine, the box "VMs" will always say "No Records found"

1. Click on the ***Provisioning*** tab to see the output of the Ansible Playbook

    ![ansible Playbook output](../../common/img/ansible-playbook-output.png)

    If the Playbook execution has not completed, you can click the reload icon to refresh the information. The ***Reload*** icon is represented by a little arrow, left of the ***Configuration*** menu.

    ![reload icon](../../common/img/reload-icon.png)

    ***Note:*** If the Playbook execution has not started yet, you might not see any details in the "Provisioning" tab. Wait a minute and reload once more.

### Verify Playbook results

To make sure the user was really created, follow these steps.

1. Click on your username on the top right and click on ***Configuration***

    ![navigate to configuration](../../common/img/navigate-to-configuration.png)

1. Click on ***Access Control*** in the accordion on the left

    ![navigate to access control](../../common/img/access-control.png)

1. Click on ***Users*** and you should see the user you just created (in this screenshot the user is called "example")

    ![user example exists](../../common/img/user-example.png)

1. OPTIONALLY: If you want, you can log out of CloudForms and try to log in with the user you just created. Click on your username on the top right and ***Logout***.

    ![logout](../../common/img/logout.png)

## Build a Service Catalog to deploy Virtual Machines

TODO: This should be replaced by a better example, since we do not want to use vCenter in any lab.

In this second part of the lab we want to use an Ansible Playbook to deploy a Virtual Machine in VMware vCenter. The necessary Playbook should already be in your repository.

1. Click on ***Catalog Items*** in the accordion on the left

    ![navigate to service catalog items](../../common/img/add-catalog-item.png)

1. Click on ***Configuration*** -> ***Add a New Catalog Item***

1. Select ***Ansible Playbook*** as "Catalog Item Type"

    ![add catalog item ansible Playbook](../../common/img/add-catalog-item-ansible-playbook.png)

    ***Note:*** Do not select Ansible Tower! We do not use Ansible Tower in this lab, but the embedded Ansible role of CloudForms.

1. Fill out the form to define the Service Catalog Item:

    The name of the Service Catalog Item:

    ***Name:*** Provision Virtual Machine

    More description details about the Service Catalog Item

    ***Description:*** Order this catalog item provision a Virtual Machine on VMware vCenter

    Check this box to make the Service Catalog Item visible in the Service Catalog. This remains unselected for Service Catalog Items which are still in draft mode or should only be used as a part of a Service Catalog Bundle:

    ***Display in Catalog:*** Yes (check the box)

    The Service Catalog in which this Service Catalog Item should be listed:

    ***Catalog:*** Ansible

    The Git repository from which we want to run our Playbook:

    ***Repository:*** Github

    The name of the actual Playbook:

    ***Playbook:*** create_vm_from_template.yml

    Credentials used to run the Playbook:

    ***Machine Credentials:*** CFME Default Credentials

    If you want to run your Playbook against a Cloud Provider, you have to select which one:

    ***Cloud Type:*** VMware

    The credentials used to log into the Cloud Provider:

    ***Cloud Credentials:*** vCenter

    In the box ***Variables & Default Values*** we can enter the variables the Playbook requires. Those variables are defined in the Ansible Playbook. By specifying them here, CloudForms can populated those variables when somebody order the Service Catalog Item.

    If you want to learn more about variables in Ansible Playbooks, have a look at the [Ansible Documentation](http://docs.ansible.com/ansible/playbooks_variables.html).

    ***Variable:*** vcenter_hostname

    ***Default:*** vcenter.example.com

    Click on the little plus icon (+) to save the variable. Repeat the process for the second variable:

    ***Variable:*** esxi_host

    ***Default:*** 192.168.0.51

    Click on the little plus icon (+) to save the variable. Repeat the process for the second variable:

    ***Variable:*** datacenter

    ***Default:*** DC01

    Click on the little plus icon (+) to save the variable. Repeat the process for the second variable:

    ***Variable:*** template

    ***Default:*** rhel6tmpl

    Click on the little plus icon (+) to save the variable. Repeat the process for the second variable:

    ***Variable:*** vmname

    ***Default:*** changeme

    Click on the little plus icon (+) to save the variable.

    ***Dialog:*** create new

    ***Dialog name:*** provision-vm-vcenter

    ![create user service dialog](../../common/img/vm-from-template-prov.png)

1. Click on ***Add*** to save the Service Catalog Item. It can take a few moments for the changes to be saved.

    ![catalog item was created](../../common/img/vm-prov-catalog-item-created.png)

### Order the Virtual Machine Provisioning Service Catalog Item

Once more, we want to test the result and see everything works as expected.

1. Navigate to ***Services*** -> ***Catalogs***

    ![navigate to service catalogs](../../common/img/navigate-to-service-catalog.png)

1. Click on the Service Catalog Item we just created "Provision Virtual Machine"

    ![provision virtual machine catalog item](../../common/img/provision-vm-catalog-item.png)

1. Click ***Order***

1. If you specified the dialog elements like described before, your form should look like this and all the provided default values can be accepted.

TODO: # avaleror: Maybe showing that this info can be hidden could be interesting ?? I´ve seen that later you show this, but I still think that commenting here as an intro could be handy.


    ![provision virtual machines details](../../common/img/provision-vm-details.png)

1. Click on ***Submit***

    After you click on "Submit" you will be redirected to the requests queue.

    ![requests queue after ordering provision VM](../../common/img/requests-queue-after-vm-prov.png)

### Monitor VM provisioning Playbook execution

When executing an Ansible Playbook with the embedded role in CloudForms, a "Service" object is automatically created. This service object gives us more details about the executed Playbook. It provides the output of the Playbook and it allows us to trigger retirement.

1. Navigate to ***Services*** -> ***My Services***

    ![navigate to my services](../../common/img/navigate-to-my-services.png)

1. You should see a new tile representing the Ansible Playbook Service you just ordered

    ***Note:*** If you don't see the tile yet, wait a minute and try again.

    ![create user service tile](../../common/img/my-service-provision-vm-tile.png)

1. After clicking on the icon, we can see more details about the service which was created

    ![create user service details](../../common/img/vm-prov-service-details.png)

    Since this Service does not create a Virtual Machine, the box "VMs" will always say "No Records found"

1. Click on the ***Provisioning*** tab to see the output of the Ansible Playbook

    ![ansible Playbook output](../../common/img/vm-prov-ansible-Playbook-output.png)

    If the Playbook execution has not completed, you can click the reload icon to refresh the information. The ***Reload*** icon is represented by a little arrow, left of the ***Configuration*** menu.

    ![reload icon](../../common/img/reload-icon.png)

## Extend CloudForms builtin Capabilities

In this lab you have so far learned how to use Ansible Playbooks to orchestrate and execute configuration actions. CloudForms is internally using a powerful and extensible framework that defines what happens "under the hood". This feature is called "Automate". "Automate" allows us to understand how things are done and even more interestingly, it allows us to add features which are not coming out of the box.

"Automate" code can either be developed directly in the User Interface, or it can be imported from a Git repository. For this lab we want to keep things simple. We will add a Git repository with a simple method to make the Service Dialog easier to use.

### Add a Git repository for Automate

TODO: Do we need a new project with better code examples? The Automate code doesn't make sense anymore either, since it returns a list of vCenters - which we don't use anymore

TODO: # avaleror: Maybe would be interesing explain a little bit that the Git Respositories Owner has been activated for this point, and the implications that it have.


"Automate" code can either be developed and written directly in the CloudForms Web UI, or it can be imported from a Git repository. We will do the latter:

1. Navigate to ***Automation*** -> ***Automate*** -> ***Import/Export***

    ![navigate to automate import/export](../../common/img/navigate-to-automate-import-export.png)

1. Use the following URL to access the Git repository:

    [https://github.com/cbolz/partner-conference-2017-labs.git](https://github.com/cbolz/partner-conference-2017-labs.git)

    ![adding the Automate Git repository](../../common/img/adding-automate-git.png)

1. Click ***Submit***. It will take a few moments to check the Git repository.

1. The "Branch/Tag" and "Branch" fields allow us to import different tags or branches, for example "Development", "Testing", "QA", etc.

    For this lab, we stick with the defaults and click on ***Submit***

    ![select Automate tag or branch](../../common/img/select-automate-tag-branch.png)

1. The first import can take a few moments. After that you should see the following confirmation:

    ![after first Automate import](../../common/img/after-first-automate-import.png)

### Verify Automate import

We want to make sure the Automate Code was properly imported.

1. Navigate to ***Automation*** -> ***Automate*** -> ***Explorer***

    ![navigate to Automate Explorer](../../common/img/navigate-to-automate-explorer.png)

1. "Automate" code is organized in "Datastores". Two Datastores are shipped with CloudForms:

    - ManageIQ: These methods are a verbatim copy of the Open Source Community version
    - RedHat: These methods are only shipped with Red Hat CloudForms and are supported by Red Hat

    You can now see an additional third Datastore called "Lab", which is the one you just imported. Users can create as many additional datastores as they want, but they can not modify or delete the two datastores shipped with the product. Datastores are stacked and prioritized which allows separation of out of the box functionality from custom code.

TODO:  # avaleror: Name of new Domain is not Lab at this moment, keep in mind to change it. Probably comment to students that git Domain it´s locked and they can't modify it from CF UI, and they have to modfy it outside CF and push changes to git repo.

    The screenshot was created after expanding all folders (which are actually called "Namespaces" and "Classes":

    ![Automate with custom method](../../common/img/automate-with-custom-method.png)

This concludes the preparation for the next part of the lab.

### Optimize the Dialog

The Service Dialog we created so far, is not ideal for most use cases. We want users to focus on getting their service as quickly and easily as possible. An ideal Service Dialog only asks the absolutely necessary questions. With this in mind, we can optimize the automatically created Service Dialog created in the previous part of the lab.

1. Navigate to ***Automation*** -> ***Automate*** -> ***Customization***

    ![navigate to customization](../../common/img/navigate-to-customization.png)

1. Click on ***Service Dialog*** in the accordion on the left

    ![navigate to service dialogs](../../common/img/service-dialog-accordion.png)

1. Click on the Dialog which was created in the previous step "provision-vm-vcenter"

1. Click on ***Configuration*** -> ***Copy this Dialog***. We want to keep the original version of the Dialog, which will allow us to have a backup.

1. Edit the Label and Description to something a bit more meaningful

    ***Label:*** provision-vm-vcenter-v2

    ***Description:*** Optimized version of the Service Dialog

    ***Note:*** Do not click on ***Add*** yet, we want to do some more changes!

1. We want to do several changes on this Dialog.

    Change the Label to something more meaningful:

    ***Label:*** provision-vm-vcenter-v2

1. The elements in the "Options" box will always be left to the default values for our Service Catalog Item to work. Since our users are never going to change any of the field in the "Options" box, we can simply delete the entire box.

    Click on the Box "Options" and then on the little trash bin icon to delete it and all its child elements.

    ![delete options box](../../common/img/delete-options-box.png)

    ***Note:*** Make sure you have highlighted the correct element! If you deleted the wrong element by accident, you can click on ***Cancel*** and start over.

1. The ESXi host which will actually create the virtual machine, is always the same in this lab. We can hide the element to simplify the Dialog further.

    Click on the Element "esxi_host" and unselect the "visible" box

    ![make host invisible](../../common/img/esxi-visibility.png)

1. The same applies for the "Datacenter". In this lab, there is only one.

    ![make datacenter invisible](../../common/img/datacenter-visibility.png)

1. To finish the our optimizations, we want to make the vCenter a dynamic drop down. Instead of providing possible values as a hard coded list, or asking the user for manual input, we can use program code to create a list of applicable options.

    In this example, we want the list of available vCenters dynamically populated (Although there is still only one vCenter and the value is questionable at best. But it's a good example of CloudForms' capabilities nonetheless)

    Click on the Element "vcenter_hostname" and change the type to "Drop down list". Then click the check box "Dynamic". This will change the form and show us new fields:

    ![form after selecting dynamic](../../common/img/vcenter-dynamic-checked.png)

    Click on "Entry Point". A window will pop up which allows us to specify which method instance should be called to populate this Element.

    Select the Instance called "get_vcenter_list" and click ***Apply***.

TODO:  # avaleror: Since code in this method is pretty simple maybe showing and commenting a little bit, would help students to understand whats is happening in the background ???

    ![select get_vcenter_list instance](../../common/img/get_vcenter_list-instance.png)

    The resulting Service Dialog Element should look like this:

    ![vcenter dynamic drop down list](../../common/img/vcenter-dynamic-drop-down.png)

1. Click on ***Add** to save all changes

### Update the Service Catalog Item

We have to change the Service Catalog Item to use the Service Dialog we just created.

1. Navigate to ***Services*** -> ***Catalogs***

    ![navigate to service catalogs](../../common/img/navigate-to-service-catalog.png)

1. Navigate to ***Catalog Items*** in the accordion on the left and click on the "Provision Virtual Machine" Service Catalog Item

    ![navigate to catalog items](../../common/img/vm-prov-service-catalog-item.png)

1. Click on ***Configuration*** -> ***Edit this Item***

1. In the ***Dialog*** Section of the UI, change the value from "provision-vm-vcenter" to "provision-vm-vcenter-v2"

    ![change dialog to provision-vm-vcenter-v2](../../common/img/dialog-vm-provision-vcenter-v2.png)

1. Click ***Save*** to commit the changes

### Test the new Service Dialog

We want to see how the resulting Service Catalog Item looks like.

1. Navigate to ***Services*** -> ***Catalogs***

    ![navigate to service catalogs](../../common/img/navigate-to-service-catalog.png)

1. Make sure you are on the "Service Catalogs" tab in the accordion on the left

1. Order the "Provision Virtual Machine" Service Catalog Item

    ![provision virtual machine](../../common/img/provision-vm-catalog-item.png)

1. Note the Service Dialog has changed compared to before. You should notice a few fields are gone and the vCenter is now a drop down list. "vCenter" should already be selected for you.

    ![new provision virtual machine dialog](../../common/img/order-new-virtual-machine-dialog.png)

1. If you want, you can go ahead and submit the order

## Policies and Ansible

In this lab we will cover how to create an action in CoudForms that executes an Ansible Playbook.

### Creating the Service

Control Policies drive Control Actions. Ansible Playbooks can now be executed as a control action, this is done by the control action calling a service. Therefore we need to create a service for the action to call.

First we need to create a Catalog to store the service in, do this by clicking Services/Catalogs and create new by clicking Configuration button and selecting Add New Catalog.

### Create a Service Catalog Item for the Policy Playbook

1. Click on ***Catalog Items*** in the accordion on the left

    ![navigate to service catalog items](../../common/img/add-catalog-item.png)

1. Click on ***Configuration*** -> ***Add a New Catalog Item***

1. Select ***Ansible Playbook*** as "Catalog Item Type"

    ![add catalog item ansible Playbook](../../common/img/add-catalog-item-ansible-playbook.png)

    ***Note:*** Do not select Ansible Tower! We do not use Ansible Tower in this lab, but the embedded Ansible role of CloudForms.

1. Fill out the form to define the service catalog item:

    ***Name:*** VM reset for CPU and Memory

    ***Description:*** Reconfigure VMware VM for CPU and Memory

    ***Display in Catalog:*** No (uncheck the box)

    ***Catalog:*** Ansible

    ***Repository:*** Github

    ***Playbook:*** vmware_reconfigure_vm.yml

    ***Machine Credentials:*** CFME Default Credentials

    ***Cloud Type*** VMware

    ***Cloud Credential*** vCenter

    In the box ***Variables & Default Values*** we can enter the variables the Playbook requires:

    ***Variable:*** vcenter_server

    ***Default:*** vcenter.example.com

    Click on the little plus icon (+) to save the variable. Repeat the process for the second variable:

    ***Variable:*** guest_server

    ***Default:*** \<TBD>

    Click on the little plus icon (+) to save the variable.

    ***Dialog:*** create new

    ***Dialog name:*** vm_reconfig

    ![vm-reconfig-service](../../common/img/vm-reconfig-service.png)

### Creating Control Action

1. Navigate to ***Control*** -> ***Explorer*** and click on the ***Actions*** accordion

    ![control-explorer](../../common/img/control-explorer.png)

1. Click on the ***Actions*** accordion

    ![actions](../../common/img/actions.png)

1. Select Configuration/Add a new Action

    ![add-new-action](../../common/img/add-new-action.png)

1. Fill out the form as follows

    ***Description:*** Reset VM for CPU and Memory

    ***Action Type:*** Run Ansible Playbook

    ***Playbook Catalog Item:*** VM reset for Memory and CPU

    ***Inventory:*** Localhost

    Leave the inventory on “Localhost” this is because the playbook that is run as part of the service you created is to be ran on the CloudForms appliance. The other options are

    - Run the playbook in the service on the machine that raises the event.
    - Comma Delimited list of Hosts.

    ![create-action-form](../../common/img/create-action-form.png)

1. Click Add

    Next we will create the Policy to call the action. The use case that will be demonstrated is when a VM changes its hardware settings, CloudForms will change it back.

### Create VM Control Policy

1. Navigate to ***Policies** and then select ***VM Control Policies***

    ![control-policies](../../common/img/control-policies.png)

1. Select Configuration/Add a New VM and Instance Control policy

    ![add-new-control-policy](../../common/img/add-new-control-policy.png)

1. In the form you just need to provide the ***Description***

    ***Description:*** Reset VM for CPU and Memory

    ![add-new-control-policy-form](../../common/img/add-new-control-policy-form.png)

### Setting Event Assignment

1. Once added click Configuration/Edit this Events Assignment

    ![edit-event-asignments](../../common/img/edit-event-asignments.png)

1. Scroll down and select “VM Settings Change” under the VM Configuration

    ![vm-settings-change](../../common/img/vm-settings-change.png)

1. Click Save

### Setting Control Action on Event

1. Click on the Event that is now save to the policy

    ![event](../../common/img/event.png)

1. Select Configuration/Edit Actions for the Policy Event

    ![edit-actions](../../common/img/edit-actions.png)

1. Scroll the Available Actions For Conditions that are TRUE and move the Action you just created to the Selected Actions

    ![actions-for-conditions](../../common/img/actions-for-conditions.png)

1. Click Save

    The policy will react to events that are “VM Settings Change”, upon the event detected it will run the action “Reconfigure VMware VM for CPU and Memory” that is in turn a Service that is a Ansible Playbook.

### Creating and Assigning Policy Profile

For a policy to work, it needs a policy profile to be attached to. The policy profile also needs to be assigned to an object in CloudForms.

1. Navigate to ***Control*** -> ***Explorer*** -> ***Policy Profiles***

    ![navigate-policy-profiles](../../common/img/navigate-policy-profiles.png)

1. Click Configuration/Add New Policy Profile

    ![add-new-policy-profile](../../common/img/add-new-policy-profile.png)

1. Provide a ***Description***

    ***Description:*** Desired State Policies

1. Move the “Reset VM for CPU and Memory” policy from available to Profile Policies list.

    ![move-policy](../../common/img/move-policy.png)

1. Click Save

### Assign the policy profile

1. Navigate to ***Compute*** -> ***Infrastructure*** -> ***Virtual Machines***

    ![navigate-compute-infrastructure-vms](../../common/img/navigate-compute-infrastructure-vms.png)

1. Select a Power Off VM

1. Go to ***Policy*** -> ***Manage Policies***

    ![assign-policy-vm](../../common/img/assign-policy-vm.png)

1. Select the “Desired State Policy Profile”

    ![assign-policy-vm2](../../common/img/assign-policy-vm2.png)

1. Click Save

    This has assigned the Desired State Policy Profile to the individual VM. When the VM is configured for CPU or Memory, CloudForms will reset it back to 1CPU and 1GB memory.

### Testing the Policy Profile

We will see the output in CloudForms in the form of a service in my services as well as the actual VM inventory will change. To see more real time, it's advised during testing to open the policy.log file on the CloudForms appliance. This shows when events are caught by CloudForms and confirms the policy matches.

Start by going to vSphere Web Client and selecting the VM that you identified for your service and policy earlier.

1. Go to the vCenter console, pick the VM you assigned the Policy and modify the CPU and Memory values to

    ***CPU:*** 3

    ***Memory:*** 4096 MB

    ![vmware-edit-settings](../../common/img/vmware-edit-settings.png)

    You can see the vSphere Web Client task running to change the CPU and Memory.

1. Go back to the CloudForms console and navigate to ***Services*** -> ***Requests***

    ![navigate-to-services-requests](../../common/img/navigate-to-services-requests.png)

1. Wait until your request (service) is finished

    ![policy-service](../../common/img/policy-service.png)

1. Go back to the vCenter console and verify that is has 1 CPU and 1 GB of RAM

    ![verify-vmware-vm](../../common/img/verify-vmware-vm.png)

## Custom buttons calling Ansible Playbooks

## Calling Ansible Playbooks from Automate

## Advanced labs

If you were able to complete all the steps and still have some time left, here are a couple of things you can do to get more familiar with CloudForms.

### Use the Self Service user Interface

The user interface we used so far is often referenced as the "Operations UI" or the "Classic UI". A new, more modern, Self Service user Interface is also available and receives improvements with every release.

The Self Service user Interface can be accessed by appending the string "self_service" to the Appliance URL.

[https://cf-&lt;GUID&gt;.labs.rhepds.com/self_service](https://cf-&lt;GUID&gt;.labs.rhepds.com/self_service)

You can login with the same credentials as before.

## Even more?

If you're already done and still have some time left, here are some ideas for advanced labs:

- try to retire the "create user" service catalog item and see if the user is indeed deleted
- try to add other Playbooks, some examples can be found on the [Official Red Hat CloudForms Blog](http://cloudformsblog.redhat.com/2017/05/31/ansible-automation-inside-cloudforms/)
- retire the virtual machine Service you ordered earlier, check what happens during retirement with the virtual machine (Is it shutdown? Deleted? Is there still a representation in the CloudForms Web UI?)
- make the second Catalog Item available for Joe Doe as well
- improve the Service Dialog and make the VM Name a mandatory field (right now, it's optional and can be left empty)
- grant Joe Doe more privileges (for example, it would be nice if he could start and stop his virtual machines)
- upload items to make the Service Catalog more appealing
- use the new Self Service user Interface by trying the "/self_service" URL on your Appliance
