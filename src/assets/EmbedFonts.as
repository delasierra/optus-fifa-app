/**
 * Created by Carlos de la Sierra on 15/2/17.
 */
package assets {
import flash.text.Font;

public class EmbedFonts {

    public static const MACPRO_HEAVY:String = "macProHeavy";
    [Embed(
            source="../../embed_assets/fonts/MarkPro-Heavy.otf",
            embedAsCFF="false",
            fontName="macProHeavy",
            mimeType="application/x-font-truetype",
            unicodeRange="U+0021-U+007E, U+00A9, U+00AE"
            )] // Main characters + Copyright and Registered glyphs
    static public var MacProHeavy:Class; // that's what the embed gets baked into
    Font.registerFont(MacProHeavy); // do this once per font

    public static const MACPRO_MEDIUM:String = "macProMedium";
    [Embed(
            source="../../embed_assets/fonts/MarkPro-Medium.otf",
            embedAsCFF="false",
            fontName="macProMedium",
            mimeType="application/x-font-truetype",
            unicodeRange="U+0021-U+007E, U+00A9, U+00AE"
            )] // Main characters + Copyright and Registered glyphs
    static public var MacProMedium:Class; // that's what the embed gets baked into
    Font.registerFont(MacProMedium); // do this once per font

    public static const MACPRO_REGULAR:String = "macProRegular";
    [Embed(
            source="../../embed_assets/fonts/MarkPro.otf",
            embedAsCFF="false",
            fontName="macProRegular",
            mimeType="application/x-font-truetype",
            unicodeRange="U+0021-U+007E, U+00A9, U+00AE"
            )] // Main characters + Copyright and Registered glyphs
    static public var macProRegular:Class; // that's what the embed gets baked into
    Font.registerFont(macProRegular); // do this once per font


}
}
