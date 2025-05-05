import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "previewContainer"]

    connect() {
        this.files = []
    }

    handleFiles() {
        this.files = [...this.files, ...Array.from(this.inputTarget.files)];
        this.renderPreviews()
    }

    renderPreviews() {
        this.previewContainerTarget.innerHTML = ""

        if (this.files.length == 0) {
            this.previewContainerTarget.classList.add("hidden")
            this.previewContainerTarget.classList.remove("flex")
        } else {
            this.previewContainerTarget.classList.remove("hidden")
            this.previewContainerTarget.classList.add("flex")
        }

        this.files.forEach((file, index) => {
            const wrapper = document.createElement("div");
            wrapper.classList.add("relative", "inline-block", "mr-2", "mb-2");

            const img = document.createElement("img");
            img.src = URL.createObjectURL(file);
            img.classList.add("w-64", "h-64", "object-cover", "rounded-md");

            const removeBtn = document.createElement("button");
            removeBtn.innerHTML = "<i class=\"bi bi-x-lg font-bold\"></i > ";
            removeBtn.classList.add(
                "absolute", "top-1", "right-1", "bg-red-200", "text-red-600",
                "rounded-full", "w-6", "h-6", "text-xs", "flex", "items-center",
                "justify-center", "shadow", "hover:bg-red-300", "cursor-pointer"
            );
            removeBtn.addEventListener("click", (e) => {
                e.preventDefault();
                this.removeImage(index);
            });

            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);
            this.previewContainerTarget.appendChild(wrapper);
        });

        this.updateInputFiles()
    }

    removeImage(index) {
        this.files.splice(index, 1)
        this.renderPreviews()
    }

    updateInputFiles() {
        const dataTransfer = new DataTransfer()
        this.files.forEach(file => dataTransfer.items.add(file))
        this.inputTarget.files = dataTransfer.files
    }
}
