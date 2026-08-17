import sys

file_path = "/Users/munday/ProjectMunday/MundayGEN/munday/lib/features/discovery/presentation/main/components/main_events_widget.dart"
with open(file_path, "r") as f:
    lines = f.readlines()

new_block = """                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(dataeventmainhome.length, (dataeventmainhomeIndex) {
                        final dataeventmainhomeItem = dataeventmainhome[dataeventmainhomeIndex];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
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
                                        DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.iDVenuse,
                                        ParamType.SupabaseDocRef,
                                      ),
                                      'distance': serializeParam(
                                        DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.distance.toString(),
                                        ParamType.String,
                                      ),
                                      'dateclick': serializeParam(
                                        getCurrentTimestamp,
                                        ParamType.DateTime,
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
                                          DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.poster,
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
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.business,
                                                      color: Color(0xFF9E9E9E),
                                                      size: 14.0,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                        child: Text(
                                                          valueOrDefault<String>(
                                                            DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.nameStore,
                                                            'Organizer',
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight: FontWeight.normal,
                                                                ),
                                                                color: Color(0xFF9E9E9E),
                                                                fontSize: 12.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons.favorite_border,
                                                color: Color(0xFF9E9E9E),
                                                size: 20.0,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.nameArtise,
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
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.access_time_filled,
                                                    color: Color(0xFF9E9E9E),
                                                    size: 12.0,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                    child: Text(
                                                      DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.date != null
                                                          ? DateFormat('EEE dd MMM • HH:mm').format(DataEventsStruct.maybeFromMap(dataeventmainhomeItem)!.date!)
                                                          : 'เวลาไม่ระบุ',
                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                            color: Color(0xFF9E9E9E),
                                                            fontSize: 12.0,
                                                          ),
                                                    ),
                                                  ),
                                                  if (DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.distance != null) ...[
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                      child: Container(
                                                        width: 4.0,
                                                        height: 4.0,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF9E9E9E),
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.location_on_outlined,
                                                      color: Color(0xFF9E9E9E),
                                                      size: 12.0,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                      child: Text(
                                                        '${valueOrDefault<String>(DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.distance.toString(), '0')} km',
                                                        style: Theme.of(context).textTheme.bodyMedium!.override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight: FontWeight.normal,
                                                              ),
                                                              color: Color(0xFF9E9E9E),
                                                              fontSize: 12.0,
                                                            ),
                                                      ),
                                                    ),
                                                  ]
                                              ]),
                                          ),
                                          if ((DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.capacity ?? 0) > 0)
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Wrap(
                                                spacing: 4.0,
                                                runSpacing: 4.0,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF222222),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    child: Text(
                                                      'Capacity: ${DataEventsStruct.maybeFromMap(dataeventmainhomeItem)?.capacity}',
                                                      style: Theme.of(context).textTheme.bodyMedium!.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                            color: Color(0xFFE0E0E0),
                                                            fontSize: 10.0,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (dataeventmainhomeIndex < dataeventmainhome.length - 1)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
"""

# Replace lines 87 to 914 (0-indexed) with the new block.
new_lines = lines[:87] + [new_block + "\n"] + lines[915:]

with open(file_path, "w") as f:
    f.writelines(new_lines)
    
print("Updated main_events_widget.dart successfully!")
