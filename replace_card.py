import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/components/main_venues_spotlight_widget.dart"
with open(file_path, "r") as f:
    lines = f.readlines()

new_block = """                      return SizedBox(
                        height: 390.0,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.88),
                          padEnds: false,
                          itemCount: pageCount,
                          itemBuilder: (context, pageIndex) {
                            final int startIndex = pageIndex * itemsPerPage;
                            final int endIndex = (startIndex + itemsPerPage > dataV.length) 
                                ? dataV.length 
                                : (startIndex + itemsPerPage);
                            final pageItems = dataV.sublist(startIndex, endIndex);

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(pageItems.length, (itemIndex) {
                                final dataVItem = pageItems[itemIndex];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            InVenusePage.routeName,
                                            queryParameters: {
                                              'idVenues': serializeParam(
                                                DataVenuesStruct.maybeFromMap(dataVItem)?.iDVenuse,
                                                ParamType.SupabaseDocRef,
                                              ),
                                              'distance': serializeParam(
                                                DataVenuesStruct.maybeFromMap(dataVItem)?.distance.toString(),
                                                ParamType.String,
                                              ),
                                              'index': serializeParam(2, ParamType.int),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(16.0),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  DataVenuesStruct.maybeFromMap(dataVItem)?.bg,
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                ),
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 12.0),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Color(0xFF9E9E9E),
                                                            size: 12.0,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                            child: Text(
                                                              'Bangkok',
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                    color: Color(0xFF9E9E9E),
                                                                    fontSize: 12.0,
                                                                  ),
                                                            ),
                                                          ),
                                                      ]),
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            width: 6.0,
                                                            height: 6.0,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFF00FF00),
                                                              shape: BoxShape.circle,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                            child: Text(
                                                              'Open',
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                    color: Color(0xFF9E9E9E),
                                                                    fontSize: 12.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        DataVenuesStruct.maybeFromMap(dataVItem)?.nameVenuse,
                                                        'ไม่ระบุ',
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                    child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.directions_car,
                                                            color: Color(0xFF9E9E9E),
                                                            size: 12.0,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                            child: Text(
                                                              'Venue • ${valueOrDefault<String>(DataVenuesStruct.maybeFromMap(dataVItem)?.distance.toString(), '0')} km',
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                    color: Color(0xFF9E9E9E),
                                                                    fontSize: 12.0,
                                                                  ),
                                                            ),
                                                          ),
                                                      ]),
                                                  ),
                                                  if ((DataVenuesStruct.maybeFromMap(dataVItem)?.eventID?.length ?? 0) > 0)
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.calendar_today,
                                                            color: Color(0xFFFFB74D),
                                                            size: 12.0,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                            child: Text(
                                                              '${DataVenuesStruct.maybeFromMap(dataVItem)?.eventID?.length} upcoming',
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                    color: Color(0xFFFFB74D),
                                                                    fontSize: 12.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  if ((DataVenuesStruct.maybeFromMap(dataVItem)?.styleMusic?.length ?? 0) > 0)
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                      child: Wrap(
                                                        spacing: 4.0,
                                                        runSpacing: 4.0,
                                                        children: (DataVenuesStruct.maybeFromMap(dataVItem)?.styleMusic ?? []).map((genre) {
                                                          return Container(
                                                            padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFF222222),
                                                              borderRadius: BorderRadius.circular(16.0),
                                                            ),
                                                            child: Text(
                                                              genre,
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                    color: Color(0xFFE0E0E0),
                                                                    fontSize: 10.0,
                                                                  ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (itemIndex < pageItems.length - 1)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                                        child: Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Color(0xFF222222),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                            );
                          },
                        ),
                      );
"""

new_lines = lines[:105] + [new_block + "\n"] + lines[516:]

with open(file_path, "w") as f:
    f.writelines(new_lines)
    
print("Updated to PageView successfully!")
