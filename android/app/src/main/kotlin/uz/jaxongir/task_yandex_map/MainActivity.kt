package uz.jaxongir.task_yandex_map
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory
import android.os.Bundle

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        //MapKitFactory.setLocale("RU") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("2aa9c13f-d231-45a2-9930-d64ceed95801") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
