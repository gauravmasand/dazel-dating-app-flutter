import 'package:dazel_dating_app/pages/edit_profile/edit_profile_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'relation_goals_component_model.dart';
export 'relation_goals_component_model.dart';

class RelationGoalsComponentWidget extends StatefulWidget {
  const RelationGoalsComponentWidget({Key? key}) : super(key: key);

  @override
  _RelationGoalsComponentWidgetState createState() =>
      _RelationGoalsComponentWidgetState();
}

class _RelationGoalsComponentWidgetState
    extends State<RelationGoalsComponentWidget> {
  late RelationGoalsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RelationGoalsComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.00, 1.00),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: FlutterFlowTheme.of(context).secondaryBackground,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
              ),
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'a67avp98' /* I'm Looking for... */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Sora',
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        fontSize: 14.0,
                      ),
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).accent4,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: MasonryGridView.builder(
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return [
                      () => Item(context, 'vsevieod', 'wli2j7pk'),
                      () => Item(context, 'vb3k7jan', 'mqo78ss1'),
                      () => Item(context, 'cgm0s3jp', 'quqik96v'),
                      () => Item(context, 'ith3jna1', 'k1zzv3s2'),
                      () => Item(context, 'zt733n6d', 'dbnzsc4d'),
                      () => Item(context, 'pwfvb850', 'd2xeznmr'),
                    ][index]();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Item(context, code, emoji) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: FlutterFlowTheme.of(context)
          .secondaryBackground,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            5.0, 5.0, 5.0, 5.0),
        child: InkWell(
          onTap: () {
            EditProfileWidget.dateType = FFLocalizations.of(context).getText(code);
            setState(() { });
            Navigator.pop(context);
          },
          child: Ink(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0.0, 10.0, 0.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 5.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        emoji,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                        fontFamily: 'Inter',
                        color:
                        FlutterFlowTheme.of(context)
                            .primaryText,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      code,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context)
                        .titleSmall
                        .override(
                      fontFamily: 'Inter',
                      color:
                      FlutterFlowTheme.of(context)
                          .primaryText,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
