import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "imagesContainer", "deleteBtn"]

    connect() {
        this.files = []
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
            this.displayEmptyMessage
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
}
