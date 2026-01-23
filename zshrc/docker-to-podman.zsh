#!/bin/bash
podman-docker-pull() {

# =================== SIMPLE WAY =========================
#
# Get all Docker image IDs (including intermediate layers)
docker images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>" | while read -r image; do
    if [ -n "$image" ]; then
        echo "Copying $image..."
        skopeo copy docker-daemon:"$image" containers-storage:"$image"
    fi
done
#
#
#
# =================== ADVANCED WAY =========================

#
# # Get all images excluding dangling ones
# images=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>")
#
# # Count total images
# total=$(echo "$images" | wc -l)
# current=1
#
# echo "Found $total images to copy"
#
# for image in $images; do
#     # Skip empty lines
#     [ -z "$image" ] && continue
#
#     echo "[$current/$total] Processing: $image"
#
#     # Skip if image is just a tag without repository (e.g., ":latest")
#     if [[ "$image" == ":"* ]]; then
#         echo "  Skipping invalid image format: $image"
#         continue
#     fi
#
#     # Copy the image
#     if skopeo copy docker-daemon:"$image" containers-storage:"$image"; then
#         echo "  ✓ Successfully copied"
#     else
#         echo "  ✗ Failed to copy $image"
#         # Try with different tag format
#         repo=$(echo "$image" | cut -d: -f1)
#         tag=$(echo "$image" | cut -d: -f2)
#         if [ "$tag" = "latest" ]; then
#             echo "  Retrying without tag..."
#             skopeo copy docker-daemon:"$repo" containers-storage:"$repo"
#         fi
#     fi
#
#     ((current++))
#     echo
# done
#
# echo "Migration complete!"
}
