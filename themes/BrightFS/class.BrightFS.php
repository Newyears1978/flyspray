<?php
class BrightFS_HtmlHelper
{
	
	private $baseUrl = '';
	private $themeUrl = '';
	private $_docType = '';
	private $_indentCharacter = "\t";
	private $_disableCache = true;
	
	protected $_docTypes = array(
		'html4-strict' => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">',
		'html4-trans' => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">',
		'html4-frame' => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">',
		'html5' => '<!DOCTYPE html>',
		'xhtml-strict' => '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
		'xhtml-trans' => '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">',
		'xhtml-frame' => '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">',
		'xhtml11' => '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">'
	);
	
	public function initialize($baseUrl, $themeUrl, $docType = 'html5')
	{
		$this->baseUrl = $this->noXSS(rtrim($baseUrl, '/'));
		$this->themeUrl = $this->noXSS(rtrim($themeUrl, '/'));
		
		$this->_docType = 'html4-strict';
		if ( isset($this->_docTypes[$docType]) ) $this->_docType = $docType;
	}
	
	public function docType()
	{
		echo $this->_docTypes[$this->_docType] . PHP_EOL;
	}
	
	public function title($title)
	{
		echo '<title>' . $title . '</title>';
	}
	
	public function charset()
	{
		if ( $this->_docType = 'html5' ) echo '<meta charset="UTF-8" />';
		else echo '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
	}
	
	public function meta($name, $content, $http_equiv = false)
	{
		if ( $http_equiv ) $_name = 'http-equiv'; else $_name = 'name';
		echo '<meta ' . $_name . '="' . $name . '" content="' . $content . '" />' .PHP_EOL;
	}
	
	public function css($path, $media = '', $condition = null)
	{
		if ( !is_null($condition) ) echo '<!--[if '.$condition.']>' . PHP_EOL;
		echo '<link rel="stylesheet" type="text/css" href="' . $this->getUrl($path) . ($this->_disableCache ? '?c='.time() : '') . '" ';
		echo ($media != '' ? 'media="' . $media . '"' : '').' />' . PHP_EOL;
		if ( !is_null($condition) ) echo '<![endif]-->' . PHP_EOL;
	}
	
	public function section($path)
	{
		echo '<link rel="section" type="text/html" href="' . $this->getUrl($path) . '" />' . PHP_EOL;
	}
	
	public function rss($path, $title = '')
	{
		echo '<link rel="alternate" type="application/rss+xml" title="'. $title .'" href="' . $this->getUrl($path);
		echo '" />' . PHP_EOL;
	}
	
	public function script($path, $condition = null)
	{
		if ( !is_null($condition) ) echo '<!--[if '.$condition.']>' . PHP_EOL;
		echo '<script type="text/javascript" src="' . $this->getUrl($path) . ($this->_disableCache ? '?c='.time() : '') . '"></script>' . PHP_EOL;
		if ( !is_null($condition) ) echo '<![endif]-->' . PHP_EOL;
	}
	
	public function scriptBlock($content = '')
	{
		if ( trim($content) == '' ) return;
		echo '<script type="text/javascript">' . $content . '</script>' . PHP_EOL;
	}
	
	public function favicon($icon = '')
	{
		if ( $icon != '' ) echo '<link rel="icon" type="image/png" href="' . $this->noXSS($icon) . '" />' . PHP_EOL;
	}
	
	public function styleBlock(array $styles)
	{
		if ( !is_array($styles) ) return;
		echo '<style type="text/css">' . PHP_EOL;
		$this->styleLines($styles, true);
		echo '</style>' . PHP_EOL;
	}
	
	public function styleLines(array $styles, $indented = false)
	{
		if ( !is_array($styles) ) return;
		foreach ($styles as $style => $value) echo ($indented ? $this->_indentCharacter : '') . $style . ':' . $value . ';'. PHP_EOL;
	}
	
	public function setIndentCharacter($indentCharacter)
	{
		$this->_indentCharacter = $indentCharacter;
	}
	
	public function setDisableCache($disableCache)
	{
		$this->_disableCache = $disableCache;
	}
	
	public function callHead($callbackFunction)
	{
		if (function_exists($callbackFunction)) call_user_func($callbackFunction);
	}
	
	private function getUrl($url)
	{
		return $this->noXSS((substr($url, -1) == '/' ? $url : str_replace('@base', $this->baseUrl, str_replace('@theme', $this->themeUrl, $url))));
	}
	
	public function noXSS($data)
	{
		if ( empty($data) || is_numeric($data) ) {
			return $data;
		} elseif ( is_string($data) ) {
			return htmlspecialchars($data, ENT_QUOTES, 'utf-8');
		}
		return '';
	}
	
}

class BrightFS
{
	/** @var BrightFS_HtmlHelper */ public $htmlHelper;
	
	public function __construct()
	{
		$this->htmlHelper = new BrightFS_HtmlHelper();
	}
	
	public function dokuwiki($name, $inputId, $rows = 15, $content = '', $previewId = null, $baseurl = '')
	{
		$result = '';
		
		$result .= '<div class="dokuwiki-area" style="display: inline-block">
			  <div class="dokuwiki-toolbar"><div class="dokuwiki-toolbar-content">';
		if ($previewId != null) $result .= '<button id="'. $inputId . $previewId .'" type="button" data-ac="1" tabindex="0" class="ggl button gray" onclick="douwikiPreview(\'' . $inputId . '\', \'' . $baseurl . '\', \'' . $previewId . '\');"><i class="fa fa-eye"></i> ' . Filters::noXSS(L('preview')) . '</button>';
		$result .= '<div class="pull-right dw_buttons">
					  <div class="ggl calculator" style="float:left;padding-left: 5px;">
						  <button type="button" class="ggl button calc" title="Bold" onclick="surroundText(\'**\', \'**\', \'' . $inputId . '\'); return false;"><i class="fa fa-bold"></i></button>
						  <button type="button" class="ggl button calc" title="Italic" onclick="surroundText(\'//\', \'//\', \'' . $inputId . '\'); return false;"><i class="fa fa-italic"></i></button>
						  <button type="button" class="ggl button calc" title="Underline" onclick="surroundText(\'__\', \'__\', \'' . $inputId . '\'); return false;"><i class="fa fa-underline"></i></button>
						  <button type="button" class="ggl button calc" title="Strikethrough" onclick="surroundText(\'<del>\', \'</del>\', \'' . $inputId . '\'); return false;"><i class="fa fa-strikethrough"></i></button>
					  </div>
											  
					  <div class="ggl calculator" style="float:left;padding-left: 5px;">
						  <div class="ggl dropdown">
							  <a href="#" class="ggl button gray"><i class="fa fa-header"></i><span class="toggle"></span></a>
							  <div class="ggl dropdown-slider">
								  <a href="#" class="ddm" title="Header 1" onclick="surroundText(\'======\', \'======\', \'' . $inputId . '\'); return false;"><span class="label">Header 1</span></a>
								  <a href="#" class="ddm" title="Header 2" onclick="surroundText(\'=====\', \'=====\', \'' . $inputId . '\'); return false;"><span class="label">Header 2</span></a>
								  <a href="#" class="ddm" title="Header 3" onclick="surroundText(\'====\', \'====\', \'' . $inputId . '\'); return false;"><span class="label">Header 3</span></a>
							  </div>
						  </div>
					  </div>
					  
					  <div class="ggl calculator" style="float:left;padding-left: 5px;">
						  <button type="button" class="ggl button calc" title="Insert image" onclick="surroundText(\'{{http://\', \'}}\', \'' . $inputId . '\'); return false;"><i class="fa fa-picture-o"></i></button>
						  <button type="button" class="ggl button calc" title="Insert list" onclick="replaceText(\'\n  * \', \'' . $inputId . '\'); return false;"><i class="fa fa-list"></i></button>
						  <button type="button" class="ggl button calc" title="Insert number list" onclick="replaceText(\'\n  - \', \'' . $inputId . '\'); return false;"><i class="fa fa-list-ol"></i></button>
						  <button type="button" class="ggl button calc" title="Insert horizontal line" onclick="replaceText(\'----\', \'' . $inputId . '\'); return false;"><i class="fa fa-minus"></i></button>
					  </div>
					  
					  <div class="ggl calculator" style="float:left;padding-left: 5px;">
						  <button type="button" class="ggl button calc" title="Insert hyperlink" onclick="surroundText(\'[[http://example.com|External Link\', \']]\', \'' . $inputId . '\'); return false;"><i class="fa fa-link"></i></button>
						  <button type="button" class="ggl button calc" title="Insert mail" onclick="surroundText(\'[[\', \']]\', \'' . $inputId . '\'); return false;"><i class="fa fa-envelope-o"></i></button>
						  <button type="button" class="ggl button calc" title="Insert FTP link" onclick="surroundText(\'[[ftp://\', \']]\', \'' . $inputId . '\'); return false;"><i class="fa fa-server"></i></button>
					  </div>
					  
					  <div class="ggl calculator" style="float:left;padding-left: 5px;">
						  <button type="button" class="ggl button calc" title="Insert code" onclick="surroundText(\'<code>\', \'</code>\', \'' . $inputId . '\'); return false;"><i class="fa fa-code"></i></button>
						  <button type="button" class="ggl button calc" title="Select a code to insert" onclick="jQuery(\'#geshi-lang-list\').data(\'iid\', \'' . $inputId . '\'); jQuery(\'#geshi-lang-modal\').modal();"><i class="fa fa-codepen"></i></button>
					  </div>
				  </div></div>
			  </div>
			  <div class="dokuwiki-text">
				  <textarea name="' . $name . '" rows="' . $rows . '" id="' . $inputId . '">' . htmlspecialchars($content, ENT_QUOTES, 'utf-8') . '</textarea>';
		if ($previewId != null) $result .= '<div class="dokuwiki-preview" id="' . $previewId . '">Nothing to preview</div>';
		$result .= '</div>
		  </div>';
		
		return $result;
	}
	
	public function dokuwikiPreviewJS($previewText = 'Preview', $editText = 'Edit')
	{
		echo <<<EOD
<script type="text/javascript">		
	window.douwikiPreview = function(inputId, baseUrl, previewId) {
		
		if ( jQuery('#' + inputId + previewId).length && jQuery('#' + inputId + previewId).data('ac') == 1 )
		{
			jQuery('#' + inputId + previewId).data('ac', 0);
			jQuery('#' + inputId + previewId).html('<i class="fa fa-edit"></i> $editText');
			
			jQuery('#' + previewId).show();
			jQuery('#' + inputId).hide();
			jQuery('.dw_buttons').hide();
			
			var preview = $(previewId);
			emptyElement(preview);
		
			var img = document.createElement('i');
			img.className='fa fa-spinner fa-spin fa-lg';
			img.id = 'temp_img';
			img.alt = 'Loading...';
			preview.appendChild(img);
		
			var text = $(inputId).value;
			if (text.trim() == '') text = 'Nothing to preview';
			text = encodeURIComponent(text);
			var url = baseUrl + 'js/callbacks/getpreview.php';
			var myAjax = new Ajax.Updater(previewId, url, {parameters:'text=' + text, method: 'post'});
		}	
		else if ( jQuery('#' + inputId + previewId).length && jQuery('#' + inputId + previewId).data('ac') == 0 )
		{
			jQuery('#' + inputId + previewId).data('ac', 1);
			jQuery('#' + inputId + previewId).html('<i class="fa fa-eye"></i> $previewText');
			jQuery('#' + inputId).show();
			jQuery('#' + previewId).hide();
			jQuery('.dw_buttons').show();
		}
	}
</script>
EOD;

	}
	
	function dokuwikiGeshiLanguages()
	{
		$geshiPath = $_SERVER['DOCUMENT_ROOT'].'/plugins/dokuwiki/inc/geshi/';
		$geshiFiles = array();
		foreach (glob($geshiPath . "*.php") as $file) $geshiFiles[] = str_replace($geshiPath, '', str_replace('.php', '', $file));
		ksort($geshiFiles);
		
		$result = '<div id="geshi-lang-modal" style="display:none;">';
		$result .= '<label for="geshi-lang-list" style="width: 23%; margin-top: 4px; display: inline-block;">' . $this->htmlHelper->noXSS(L('language')) . '</label>';
		$result .= '<select id="geshi-lang-list" data-iid="" class="s2" style="width: 63%">';
		$result .= '<option value="">' . $this->htmlHelper->noXSS(L('none')) . '</option>';
		foreach ($geshiFiles as $language)
		{
			$result .= '<option value="'.$language.'">' . strtoupper($language) . '</option>';
		}
		$result .= '</select>';
		$result .= '<button class="ggl button green pull-right" style="width:10%" ';
		$result .= 'onclick="jQuery.modal.close(); surroundText(\'<code \' + jQuery(\'#geshi-lang-list\').val()  + \'>\', \'</code>\', jQuery(\'#geshi-lang-list\').data(\'iid\'));';
		$result .= 'jQuery(\'#geshi-lang-list\').data(\'iid\', \'\');';
		$result .= 'return false;">';
		$result .= 'OK</button>';
		$result .= '</div>';
		
		echo $result;
	}
}
