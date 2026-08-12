import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/main_page.dart"
with open(file_path, "r") as f:
    content = f.read()

old_text = """                                MainEventsWidget(
                                  model: _model,
                                  currentUserLocationValue:
                                      currentUserLocationValue,
                                  animationsMap: animationsMap,
                                ),
                                MainVenuesSpotlightWidget(
                                  model: _model,
                                  currentUserLocationValue:
                                      currentUserLocationValue,
                                  animationsMap: animationsMap,
                                  onStateChanged: () => safeSetState(() {}),
                                ),"""

new_text = """                                MainVenuesSpotlightWidget(
                                  model: _model,
                                  currentUserLocationValue:
                                      currentUserLocationValue,
                                  animationsMap: animationsMap,
                                  onStateChanged: () => safeSetState(() {}),
                                ),
                                MainEventsWidget(
                                  model: _model,
                                  currentUserLocationValue:
                                      currentUserLocationValue,
                                  animationsMap: animationsMap,
                                ),"""

if old_text in content:
    content = content.replace(old_text, new_text)
    with open(file_path, "w") as f:
        f.write(content)
    print("Widgets swapped successfully!")
else:
    print("Error: Could not find the exact text block to swap.")
