import { backend } from "declarations/backend";

let postsContainer;
let loadingIndicator;

async function init() {
    postsContainer = document.getElementById('posts-container');
    loadingIndicator = document.getElementById('loading');
    
    await loadPosts();
    await initializeBlog();
}

async function showLoading(show) {
    loadingIndicator.classList.toggle('d-none', !show);
}

async function initializeBlog() {
    try {
        await backend.initialize();
        await loadPosts();
    } catch (error) {
        console.error("Error initializing blog:", error);
    }
}

async function loadPosts() {
    try {
        showLoading(true);
        const posts = await backend.getAllPosts();
        displayPosts(posts);
    } catch (error) {
        console.error("Error loading posts:", error);
    } finally {
        showLoading(false);
    }
}

function displayPosts(posts) {
    postsContainer.innerHTML = '';
    
    posts.forEach(post => {
        const date = new Date(Number(post.timestamp / 1000000n));
        const postElement = document.createElement('div');
        postElement.className = 'card mb-4';
        postElement.innerHTML = `
            <div class="card-body">
                <h2 class="card-title">${post.title}</h2>
                <p class="card-text text-muted">${date.toLocaleDateString()}</p>
                <div class="card-text content">
                    ${post.content.split('\n').map(para => `<p>${para}</p>`).join('')}
                </div>
            </div>
        `;
        postsContainer.appendChild(postElement);
    });
}

window.addEventListener('load', init);
