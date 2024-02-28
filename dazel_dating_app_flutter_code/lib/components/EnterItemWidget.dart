
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';

Widget Item(BuildContext context, String title, {bool first = false, function, selected = false}) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(30.0, first ? 70 : 10.0, 30.0, 0.0),
    child: InkWell(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 55.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(17.0),
          border: Border.all(
            color: Colors.black,
            width: selected ? 0.5 : 0.1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    20.0, 0.0, 0.0, 0.0),
                child: Text(
                  title,
                  // FFLocalizations.of(context).getText('wqpt5lme' /* Active */,),
                  style: FlutterFlowTheme.of(context)
                      .bodyMedium
                      .override(
                    fontFamily: 'Inter',
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}