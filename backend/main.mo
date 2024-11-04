import Bool "mo:base/Bool";
import Stack "mo:base/Stack";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";
import Order "mo:base/Order";

actor {
    public type BlogPost = {
        id: Nat;
        title: Text;
        content: Text;
        timestamp: Int;
    };

    stable var posts : [BlogPost] = [];
    stable var nextId : Nat = 0;

    public func createPost(title: Text, content: Text) : async BlogPost {
        let post : BlogPost = {
            id = nextId;
            title = title;
            content = content;
            timestamp = Time.now();
        };
        
        let buffer = Buffer.fromArray<BlogPost>(posts);
        buffer.add(post);
        posts := Buffer.toArray(buffer);
        nextId += 1;
        post
    };

    public query func getAllPosts() : async [BlogPost] {
        Array.sort(posts, func(a: BlogPost, b: BlogPost) : Order.Order {
            if (b.timestamp > a.timestamp) #less
            else if (b.timestamp < a.timestamp) #greater
            else #equal
        })
    };

    public query func getPost(id: Nat) : async ?BlogPost {
        Array.find<BlogPost>(posts, func(post: BlogPost) : Bool {
            post.id == id
        })
    };

    public func initialize() : async () {
        if (posts.size() == 0) {
            ignore await createPost(
                "Infrastructure Management and Architecture",
                "Infrastructure management is a fundamental responsibility of Platform Operations teams that encompasses several critical areas:\n\n1. Cloud Resource Management:\n- Designing and implementing cloud architecture across multiple providers (AWS, Azure, GCP)\n- Managing compute resources, storage solutions, and networking components\n- Implementing Infrastructure as Code (IaC) using tools like Terraform\n- Optimizing cloud costs and resource utilization\n\n2. Configuration Management:\n- Maintaining consistent server configurations across environments\n- Implementing configuration management tools (Ansible, Chef, Puppet)\n- Managing environment-specific configurations\n- Ensuring configuration version control\n\n3. Capacity Planning:\n- Forecasting resource needs based on growth patterns\n- Implementing auto-scaling solutions\n- Managing resource allocation across services\n- Monitoring and optimizing resource usage\n\n4. High Availability:\n- Designing redundant systems and failover mechanisms\n- Implementing load balancing solutions\n- Managing data replication and backup strategies\n- Ensuring geographic distribution of services"
            );
            
            ignore await createPost(
                "Monitoring and Observability",
                "Comprehensive monitoring and observability are essential for maintaining system health:\n\n1. Monitoring Systems:\n- Implementing monitoring tools (Prometheus, Grafana, DataDog)\n- Setting up custom metrics and dashboards\n- Configuring real-time alerting systems\n- Monitoring system performance and health\n\n2. Log Management:\n- Centralizing log collection and analysis\n- Implementing log retention policies\n- Setting up log analysis tools (ELK Stack, Splunk)\n- Creating log-based alerts and notifications\n\n3. Performance Metrics:\n- Tracking system and application performance\n- Monitoring resource utilization\n- Implementing APM solutions\n- Creating performance baselines\n\n4. Alerting Systems:\n- Designing alert hierarchies and escalation paths\n- Setting up on-call rotations\n- Implementing alert correlation\n- Managing alert fatigue"
            );

            ignore await createPost(
                "Security and Compliance",
                "Security management is crucial for protecting infrastructure and data:\n\n1. Security Implementation:\n- Managing access control and authentication\n- Implementing encryption at rest and in transit\n- Conducting security audits and assessments\n- Managing security certificates and keys\n\n2. Compliance Management:\n- Ensuring regulatory compliance (GDPR, SOC2, etc.)\n- Implementing security policies and procedures\n- Conducting regular compliance audits\n- Maintaining compliance documentation\n\n3. Vulnerability Management:\n- Regular security scanning and testing\n- Patch management and updates\n- Security incident response\n- Penetration testing coordination\n\n4. Network Security:\n- Implementing firewalls and security groups\n- Managing VPNs and network access\n- DDoS protection\n- Network monitoring and intrusion detection"
            );

            ignore await createPost(
                "Disaster Recovery and Business Continuity",
                "Ensuring business continuity through robust disaster recovery:\n\n1. Backup Strategies:\n- Implementing automated backup solutions\n- Managing backup retention policies\n- Testing backup integrity\n- Implementing cross-region backups\n\n2. Disaster Recovery Planning:\n- Creating and maintaining DR plans\n- Regular DR testing and validation\n- Managing failover procedures\n- Documenting recovery processes\n\n3. Business Continuity:\n- Defining RPO and RTO objectives\n- Implementing business continuity procedures\n- Managing service level agreements\n- Coordinating with stakeholders\n\n4. Incident Management:\n- Establishing incident response procedures\n- Managing major incidents\n- Conducting post-incident reviews\n- Implementing lessons learned"
            );

            ignore await createPost(
                "Automation and DevOps Practices",
                "Automation is key to efficient platform operations:\n\n1. CI/CD Pipeline Management:\n- Maintaining deployment pipelines\n- Managing build and test automation\n- Implementing deployment strategies\n- Ensuring pipeline security\n\n2. Infrastructure Automation:\n- Implementing infrastructure as code\n- Managing configuration automation\n- Automating routine tasks\n- Creating self-service capabilities\n\n3. Script Development:\n- Creating automation scripts\n- Managing script repositories\n- Implementing testing frameworks\n- Maintaining documentation\n\n4. Tool Integration:\n- Managing DevOps toolchain\n- Implementing tool integrations\n- Maintaining automation platforms\n- Evaluating new tools and technologies"
            );
        };
    };
}
