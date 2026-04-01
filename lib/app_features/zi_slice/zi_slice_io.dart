export 'zata/actions_on_tile.dart';
export 'zata/controller.dart';
export 'zata/form.dart';
export 'tile_widget.dart';
export 'view_ui.dart';

/*
─── Zi_Slice — import this in your feature ──────────────────────────────────
Step 1: copy x_zi_slice/ folder
Step 2: rename folder to your feature name
Step 3: rename XxxSlice → YourFeature in all files
Step 4: import your_feature_io.dart
─────────────────────────────────────────────────────────────────────────────

## Developer Steps — 10x fast to new feature

1. Copy x_zi_slice/ → rename to your_feature/
2. Find+Replace XxxSlice → YourFeature (IDE does this in 1 click)
3. Add your fields in controller.dart
4. Add your inputs in form.dart
5. Add your tile content in tile_widget.dart
6. Wire your viewmodel calls in controller.dart submit/update/delete
7. Import your_feature_io.dart wherever needed
*/
