<!-- .slide: class="two_column_list" -->

## Under the Hood

### dockerd

- API endpoint
- Integration with ecosystem
- Automation
- Available on socket
- Offers certificate authentication
- Talks to containerd using gRPC

### containerd

- Distribution (push/pull)
- Container management
- Storage
- Belongs to CNCF
- Implements OCI image specification
- Donated by Docker

### runc

- Isolates processes
- Interacts with kernel
- Lightweight
- Belongs to OCI (Linux Foundation)
- Implements OCI runtime specification
- Donated by Docker in 2015