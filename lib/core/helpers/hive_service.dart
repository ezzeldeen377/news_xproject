import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
class HiveService {
  static const String _bookmarksBoxName = 'bookmarks';
  static const String _historyBoxName = 'search_history';

  /// Initialize Hive and register adapters
 static Future<void> init() async {
  await Hive.initFlutter();

  Hive.registerAdapter(NewsResponseEntityAdapter());
  Hive.registerAdapter(ArticleEntityAdapter());
  Hive.registerAdapter(SourceEntityAdapter());

  // ✅ Open the box with the correct type
  await Hive.openBox<ArticleEntity>(_bookmarksBoxName);
  await Hive.openBox<ArticleEntity>(_historyBoxName);
}

  /// Get a specific box
  static Box<T> getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

static Box<ArticleEntity> get bookmarksBox => getBox<ArticleEntity>(_bookmarksBoxName);
static Box<ArticleEntity> get historyBox => getBox<ArticleEntity>(_historyBoxName);

  
  static Future<void> addBookmark(String key, ArticleEntity value) async {
    await bookmarksBox.put(key, value);
  }
 
  static dynamic getBookmark(String key) {
    return bookmarksBox.get(key);
  }

 
  /// Get all bookmarks
  static Map<dynamic, ArticleEntity> getAllBookmarks() {
    return bookmarksBox.toMap();
  }
  

  static bool bookmarkExists(String key) {
    return bookmarksBox.containsKey(key);
  }


  static Future<void> deleteBookmark(String key) async {
    await bookmarksBox.delete(key);
  }

  static Future<void> clearBox(String boxName) async {
    await bookmarksBox.clear();
  }

  static Future<void> clearBookmarks() async {
    await clearBox(_bookmarksBoxName);
  }

  /// Add an article to search history
  static Future<void> addToHistory(ArticleEntity article) async {
    print("@@@@@@@@start adding ");
    // Use the article URL as the key to ensure uniqueness
    final key = article.url;
    
    // If the article already exists in history, delete it first
    // This ensures it will be moved to the top of the history list
    if (historyBox.containsKey(key)) {
      await historyBox.delete(key);
    }
    
    // Create a timestamp-based key to ensure newest items are first
    // Format: timestamp_url (this ensures uniqueness and proper ordering)
    final timestampKey = "${DateTime.now().millisecondsSinceEpoch}_$key";
    
    // Add the article to history with the timestamp key
    await historyBox.put(timestampKey, article);
    
    // Optional: Limit history size (keep last 50 articles)
    if (historyBox.length > 50) {
      // Sort keys by timestamp (oldest first)
      final keys = historyBox.keys.toList();
      keys.sort((a, b) => b.compareTo(a)); // Sort descending so newest timestamps are first
      // Delete the oldest item
      if (keys.isNotEmpty) {
        await historyBox.delete(keys.first);
      }
    }
  }
  
  /// Get all search history items
  static List<ArticleEntity> getAllHistory() {
    // Convert to list and reverse to get most recent first
    final historyMap = historyBox.toMap();
    final historyList = historyMap.values.toList();
    
    // Sort by most recent (if your ArticleEntity has a timestamp field)
    // Otherwise, the most recently added items will be at the end of the list
    return historyList.reversed.toList();
  }

  static Future<void> clearHistory() async {
    await historyBox.clear();
  }

  static Future<void> closeBoxes() async {
    await Hive.close();
  }
}