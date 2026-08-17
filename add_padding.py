import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/venues/venues_page.dart"
with open(file_path, "r") as f:
    content = f.read()

target = """                                                                              Expanded(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
"""
replacement = """                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
"""

content = content.replace(target, replacement)

# We also need to find where this Column is closed.
# It is closed right before the end of the Expanded.
target_close = """                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),"""
replacement_close = """                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),"""

content = content.replace(target_close, replacement_close)

with open(file_path, "w") as f:
    f.write(content)
print("Updated successfully")
