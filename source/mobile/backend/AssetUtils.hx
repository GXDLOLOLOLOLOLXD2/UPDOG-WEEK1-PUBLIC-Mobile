package mobile.backend;

import openfl.utils.Assets;
import openfl.utils.AssetType;
import openfl.display.BitmapData;
import openfl.media.Sound;
import openfl.text.Font;
import openfl.utils.ByteArray;
//import haxe.concurrent.Future;

import funkin.Paths.findAsset;
import mobile.scripting.NativeAPI;

#if sys
import sys.io.File;
#end

/**
 * `AssetUtils` é uma classe utilitária estática que fornece métodos convenientes
 * para acessar assets internos do seu projeto OpenFL.
 *
 * Ao contrário de `AssetExamples` (que é um `Sprite` para demonstração visual),
 * `AssetUtils` não precisa ser instanciado e seus métodos podem ser chamados
 * diretamente usando `mobile.backend.AssetUtils.methodName()`.
 *
 * Para que os métodos de carregamento de assets funcionem, você precisa ter os arquivos
 * de recursos especificados no seu arquivo `project.xml` na tag `<assets>`.
 * Exemplo no `project.xml`:
 * ```xml
 * <assets path="Assets" rename="assets" />
 * ```
 * E dentro da pasta 'Assets' do seu projeto, ter os arquivos de exemplo:
 * - 'image.png' (ou .jpg, .gif)
 * - 'sound.mp3' (ou .wav, .ogg)
 * - 'font.ttf' (ou .otf)
 * - 'text_data.txt'
 * - 'json_data.json'
 */
class AssetUtils
{
    /**
     * Verifica se um asset interno existe.
     * @param id O identificador do asset (ex: "assets/image.png").
     * @param type O tipo do asset (opcional, ex: AssetType.IMAGE).
     * @return True se o asset existir, false caso contrário.
     *
     * O "Contrário" (Método Externo): `openfl.filesystem.File.exists(path:String)`
     * - `File.exists()`: Verifica a existência de um arquivo ou diretório **NO SISTEMA DE ARQUIVOS** do dispositivo.
     * É para arquivos que não são parte do pacote do seu jogo (saves, downloads).
     * 
     * Comando: `mobile.backend.AssetUtils.assetExists("id", type)`
     */
    public static function assetExists(id:String, ?type:AssetType):Bool
    {
        var path = findAsset(id);
        if (path != null) {
            try {
                return path != null;
            } catch (e:Dynamic) {
                NativeAPI.showMessageBox("Asset Exists", "Checking if asset '${id}' exists: ${Assets.exists(id, type)}");
            }
        }
        return false;
        //return Assets.exists(id, type);
    }

    /**
     * Carrega e retorna os dados de bitmap de uma imagem interna.
     * @param id O identificador do asset da imagem (ex: "assets/background.jpg").
     * @return Um objeto BitmapData.
     *
     * O "Contrário" (Método Externo):
     * Você leria bytes de um arquivo de imagem com `FileStream` e depois usaria
     * `BitmapData.loadFromBytes()` para criar o BitmapData.
     */
    public static function getBitmap(id:String):BitmapData
    {
        var path = findAsset(id);
        if (path != null) {
            try {
                return Assets.getBitmapData(path);
            } catch (e:Dynamic) {
                trace('Error in load image "${path}": ${e}');
                NativeAPI.showMessageBox("Assets Error", "Failed to load image '${path}': ${e}");
            }
        }
        return null;
        /*try {
            return Assets.getBitmapData(id);
        } catch (e:Dynamic) {
            trace('Error in load image "${id}": ${e}');
            return null; // Retorna null em caso de erro
        }*/
    }

    /**
     * Carrega e retorna um objeto Sound de um arquivo de áudio interno.
     * @param id O identificador do asset de som (ex: "assets/music.mp3").
     * @return Um objeto Sound.
     *
     * O "Contrário" (Método Externo):
     * Você leria bytes de um arquivo de áudio com `FileStream` e tentaria criar
     * um Sound a partir deles (por exemplo, `Sound.fromFile()`).
     */
    public static function getSound(id:String):Sound
    {
        var path = findAsset(id);
        if (path != null) {
            try {
                return Assets.getSound(path);
            } catch (e:Dynamic) {
                trace('Error in load sound "${path}": ${e}');
                NativeAPI.showMessageBox("Assets Error", "Failed to load sound '${path}': ${e}");
            }
        }
        return null;
        /*try {
            return Assets.getSound(id);
        } catch (e:Dynamic) {
            trace('Error in load sound "${id}": ${e}');
            return null;
        }*/
    }

    /**
     * Carrega e retorna um objeto Font de um arquivo de fonte interna.
     * @param id O identificador do asset da fonte (ex: "assets/myFont.ttf").
     * @return Um objeto Font.
     *
     * O "Contrário" (Método Externo):
     * Não há uma API direta para carregar fontes de arquivos arbitrários do sistema
     * de arquivos para uso fácil com `TextFormat`. Seria um processo manual complexo.
     */
    public static function getFont(id:String):Font
    {
        var path = findAsset(id);
        if (path != null) {
            try {
                return Assets.getFont(path);
            } catch (e:Dynamic) {
                trace('Error in load font "${path}": ${e}');
                NativeAPI.showMessageBox("Assets Error", "Failed to load font '${path}': ${e}");
            }
        }
        return null;
        /*try {
            return Assets.getFont(id);
        } catch (e:Dynamic) {
            trace('Error in load font "${id}": ${e}');
            return null;
        }*/
    }

    /**
     * Carrega e retorna o conteúdo de um arquivo de texto interno como String.
     * @param id O identificador do asset de texto (ex: "assets/data.txt").
     * @return O conteúdo do arquivo como String.
     *
     * O "Contrário" (Método Externo):
     * Você leria os bytes de um arquivo de texto com `FileStream` e os converteria para String.
     */
    public static function getText(id:String):String
    {
        var path = findAsset(id);
        if (path != null) {
            try {
                return Assets.getText(path);
            } catch (e:Dynamic) {
                trace('Error in load text "${path}": ${e}');
                NativeAPI.showMessageBox("Assets Error", "Failed to load text '${path}': ${e}");
            }
        }
        return null;
        /*try {
            return Assets.getText(id);
        } catch (e:Dynamic) {
            trace('Error in load text "${id}": ${e}');
            return null;
        }*/
    }

    /**
     * Carrega e retorna os bytes brutos de um arquivo interno (útil para JSON, XML, binário).
     * @param id O identificador do asset (ex: "assets/config.json").
     * @return Um objeto ByteArray.
     *
     * O "Contrário" (Método Externo):
     * Você leria os bytes de um arquivo arbitrário do sistema de arquivos com `FileStream`.
     */
    public static function getBytes(id:String):ByteArray
    {
        var path = findAsset(id);
        if (path != null) {
            try {
                return Assets.getBytes(path);
            } catch (e:Dynamic) {
                trace('Error in load bytes "${path}": ${e}');
                NativeAPI.showMessageBox("Assets Error", "Failed to load bytes from '${path}': ${e}");
            }
        }
        return null;
        /*try {
            return Assets.getBytes(id);
        } catch (e:Dynamic) {
            trace('Error in load bytes "${id}": ${e}');
            return null;
        }*/
    }

    /**
     * Lista todos os IDs de assets internos disponíveis, opcionalmente filtrados por tipo.
     * @param type O tipo do asset para filtrar (opcional).
     * @return Uma Array de Strings com os IDs dos assets.
     *
     * O "Contrário" (Método Externo):
     * Você usaria `openfl.filesystem.File.readDirectory()` para listar arquivos
     * e subdiretórios em um caminho específico no sistema de arquivos.
     */
    public static function listAssets(?type:AssetType):Array<String>
    {
        return Assets.list(type);
    }

    /**
     * Lê o conteúdo de um asset interno (arquivo embutido no app) como texto.
     * 
     * @param id O caminho do asset (ex: "assets/data.txt").
     * @return O conteúdo do arquivo como String, ou null se não encontrado.
     *
     * Exemplo de uso:
     * ```haxe
     * var texto = mobile.backend.AssetUtils.getAssetContent("assets/data.txt");
     * if (texto != null) trace(texto);
     * else trace("Arquivo não encontrado!");
     * ```
     *
     * Este método é o "contrário" de File.getContent para assets internos:
     * - File.getContent lê arquivos do sistema de arquivos do dispositivo (externo).
     * - getAssetContent lê arquivos embutidos no app (interno), usando OpenFL Assets.
     */
    public static function getAssetContent(id:String):String
    {
        var path = findAsset(id);
        if (path != null) {
            try {
                return Assets.getText(path);
            } catch (e:Dynamic) {
                trace('Error in get asset content "${path}": ${e}');
                NativeAPI.showMessageBox("Assets Error", "Failed to get content from asset '${path}': ${e}");
            }
        }
        return null;
        /*if (Assets.exists(id)) {
            return Assets.getText(id);
        }
        return null;*/
    }

    /**
     * Ensures that the given path ends with a '/' character.
     * 
     * This function is the "opposite" (internal counterpart) of `sys.FileSystem.isDirectory`,
     * as it modifies the path string to explicitly indicate a directory by appending a trailing slash if missing.
     *
     * Usage:
     * ```
     * if (AssetUtils.isAssetDirectory("assets/images/menu/story")) {
     * // Existe pelo menos um asset nesse "diretório virtual"
     * // At least one asset exists in this "virtual directory"
     * }
     * ```
     *
     * @param path The file or directory path to normalize.
     * @return The normalized path ending with a '/'.
     */
    public static function isAssetDirectory(path:String):Bool
    {
        // Garante que termina com o caractere /.
        // =>
        // Ensures that the given path ends with a '/' character.
        if (!path.endsWith("/")) path += "/";
        for (id in Assets.list())
        {
            if (id.startsWith(path)) return true;
        }
        return false;
    }

    /*                      ______ _____ ___
       |    |  |\   | |   | \      |     |  \
       |    |  | \  | |   |  \     |____ |   |   Functions
       |    |  |  \ | |   |  /     |     |   |   LOL
       |____|  |   \| |___| /_____ |____ |__/
       "Unused"
    */

    // --- Métodos assíncronos (retornam Future) ---
    /**
     * Carrega assincronamente e retorna os dados de bitmap de uma imagem interna.
     * @param id O identificador do asset da imagem.
     * @return Um Future<BitmapData>.
     */
    /*public static function loadBitmapAsync(id:String):Future<BitmapData>
    {
        return Assets.loadBitmapData(id);
    }

    /**
     * Carrega assincronamente e retorna um objeto Sound de um arquivo de áudio interno.
     * @param id O identificador do asset de som.
     * @return Um Future<Sound>.
     */
    /*public static function loadSoundAsync(id:String):Future<Sound>
    {
        return Assets.loadSound(id);
    }

    /**
     * Carrega assincronamente e retorna o conteúdo de um arquivo de texto interno como String.
     * @param id O identificador do asset de texto.
     * @return Um Future<String>.
     */
    /*public static function loadTextAsync(id:String):Future<String>
    {
        return Assets.loadText(id);
    }

    /**
     * Carrega assincronamente e retorna os bytes brutos de um arquivo interno.
     * @param id O identificador do asset.
     * @return Um Future<ByteArray>.
     */
    /*public static function loadBytesAsync(id:String):Future<ByteArray>
    {
        return Assets.loadBytes(id);
    }*/
}