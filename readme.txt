This is my attempt to make a UIImageView zoomable when hosted inside a UIScrollView set with paging enabled. The technique used has been to identify when zooming begins (using the UIViewForZooming protocol callback) and to reset the UIScrollView's children.

It's still (obviously) a work in progress.