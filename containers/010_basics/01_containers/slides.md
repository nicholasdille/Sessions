## Why Containers

<div style="width: 32%; padding-right: 2%; float: left; text-align: center">
<p><i class="fas fa-umbrella fa-2x"></i></p>

<h3>Isolated</h3>

<p>Process Isolation</p>
<p>Resource management</p>
</div>

<div style="width: 32%; padding-right: 2%; float: left; text-align: center">
<p><i class="fas fa-suitcase fa-2x"></i></p>

<h3>Packaged</h3>

<p>Runtime environment</p>
<p>Distributable package</p>
</div>

<div style="width: 32%; float: right; text-align: center">
<p><i class="fas fa-cog fa-2x"></i></p>

<h3>Automated</h3>

<p>Builds are reproducible</p>
<p>Fast deployments</p>
</div>

---

## Internals

### Namespaces

* Used for resource isolation
* Isolation of resource usage to limit visibility
* Types are PID, network, mount

### c(ontrol)groups

* Used to limit resource usage for proceses
* Limits and measures access to...
* ...CPU, memory, network, IO