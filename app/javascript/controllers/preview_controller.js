import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "imagesContainer", "deleteBtn"]

    connect() {
        this.files = []
        this.imageCurrentlyUploading = 1
        addEventListener("direct-upload:progress", event => this.showUploadProgressDiv(event))
    }

    handleFiles() {
        this.files = [...this.files, ...Array.from(this.inputTarget.files)];
        this.createImageDivs();
        this.updateInputFiles()
    }

    createImageDivs() {
        Array.from(this.inputTarget.files).forEach((file, index) => {
            const wrapper = document.createElement("div");
            wrapper.classList.add("relative", "m-2");

            const img = document.createElement("img");
            img.src = URL.createObjectURL(file);
            img.classList.add("w-64", "h-64", "m-2", "rounded-md");

            const removeBtn = document.createElement("button");
            removeBtn.innerHTML = "Remove";
            removeBtn.classList.add("remove-img-button")

            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);

            removeBtn.addEventListener("click", (e) => {
                e.preventDefault();
                this.removeImage(index);
                e.target.parentElement.remove()
            });

            if (document.getElementById("empty-msg"))
                document.getElementById("empty-msg").remove()

            this.imagesContainerTarget.appendChild(wrapper);
        });
    }

    updateInputFiles() {
        const dataTransfer = new DataTransfer()
        this.files.forEach(file => dataTransfer.items.add(file))
        this.inputTarget.files = dataTransfer.files
    }

    removeImage(index) {
        this.files.splice(index, 1)
        this.updateInputFiles()

        if (this.imagesContainerTarget.children.length == 1)
            this.displayEmptyMessage()
    }

    removeAttachedImage(e) {
        e.target.parentElement.remove()
        if (this.imagesContainerTarget.children.length == 0)
            this.displayEmptyMessage()
    }

    displayEmptyMessage() {
        const emptyMsg = document.createElement("p")

        emptyMsg.setAttribute("id", "empty-msg")
        emptyMsg.classList.add("text-xl", "text-slate-400", "font-bold")
        emptyMsg.textContent = "No images selected"

        this.imagesContainerTarget.appendChild(emptyMsg)
    }

    showUploadProgressDiv(event) {
        let progress = event.detail.progress
        let progressDiv = document.getElementById("upload-progress-div")
        let imagesCountP = document.getElementById("images-count")
        let progressBar = document.getElementById("progress-bar")
        progressDiv.classList.remove("hidden")
        imagesCountP.textContent = `Uploading images... (${this.imageCurrentlyUploading}/${this.files.length})`
        progressBar.classList.add("transition-[width]", "duration-400")
        progressBar.style.width = `${progress}%`
        if (progress == 100)
            this.imageCurrentlyUploading++
    }
}
