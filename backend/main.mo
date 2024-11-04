import Bool "mo:base/Bool";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";
import Order "mo:base/Order";

actor {
    // Blog post type definition
    public type BlogPost = {
        id: Nat;
        title: Text;
        content: Text;
        timestamp: Int;
    };

    stable var posts : [BlogPost] = [];
    stable var nextId : Nat = 0;

    // Create a new blog post
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

    // Get all blog posts
    public query func getAllPosts() : async [BlogPost] {
        Array.sort(posts, func(a: BlogPost, b: BlogPost) : Order.Order {
            if (b.timestamp > a.timestamp) #less
            else if (b.timestamp < a.timestamp) #greater
            else #equal
        })
    };

    // Get a specific post by ID
    public query func getPost(id: Nat) : async ?BlogPost {
        Array.find<BlogPost>(posts, func(post: BlogPost) : Bool {
            post.id == id
        })
    };

    // Initialize with sample content
    public func initialize() : async () {
        if (posts.size() == 0) {
            ignore await createPost(
                "Platform Operations Overview",
                "Platform Operations teams are responsible for maintaining and optimizing the infrastructure that supports an organization's technical operations. Key responsibilities include:\n\n1. Infrastructure Management\n2. Monitoring and Alerting\n3. Performance Optimization\n4. Security Management\n5. Disaster Recovery"
            );
            ignore await createPost(
                "Infrastructure Management",
                "Infrastructure management is a core responsibility that includes:\n\n- Maintaining cloud resources\n- Managing server configurations\n- Handling capacity planning\n- Implementing automation\n- Ensuring high availability\n\nThis forms the foundation of reliable platform operations."
            );
            ignore await createPost(
                "Monitoring and Incident Response",
                "Effective monitoring and incident response involves:\n\n- Setting up monitoring tools\n- Establishing alerting thresholds\n- Creating incident response procedures\n- Conducting post-mortems\n- Implementing preventive measures\n\nThis ensures system reliability and quick problem resolution."
            );
        };
    };
}
