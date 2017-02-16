<?php
require_once(BASEDIR . '/themes/BrightFS/class.BrightFS.php');
$brightFS = new BrightFS();
$brightFS->htmlHelper->initialize($baseurl, $this->themeUrl(), 'xhtml-strict');
$brightFS->htmlHelper->docType(); ?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<?php echo Filters::noXSS(L('locale')); ?>" xml:lang="<?php echo Filters::noXSS(L('locale')); ?>">
<head>
<?php
	$brightFS->htmlHelper->title($this->_title);
	
	$brightFS->htmlHelper->charset();
	$brightFS->htmlHelper->meta('description', 'Flyspray, a Bug Tracking System written in PHP.');
	$brightFS->htmlHelper->meta('Content-Script-Type', 'text/javascript', true);
	$brightFS->htmlHelper->meta('Content-Style-Type', 'text/javascript', true);
	$brightFS->htmlHelper->meta('viewport', 'width=device-width, initial-scale=1.0');
	
	echo '<base href="'.Filters::noXSS($baseurl).'" />' . PHP_EOL;

	// Links
	$brightFS->htmlHelper->favicon($this->get_image('favicon'));
	
	echo '<link rel="index" type="text/html" id="indexlink" href="'.Filters::noXSS($baseurl).'" />' . PHP_EOL;
	
	foreach ($fs->projects as $project) $brightFS->htmlHelper->section('@base/?project=' . Filters::noXSS($project[0]));
	
	$brightFS->htmlHelper->css('@theme/theme.css', 'screen');
	$brightFS->htmlHelper->css('@theme/theme_print.css', 'print');
	$brightFS->htmlHelper->css('@theme/plugins/fonts/font-awesome/css/font-awesome.min.css');
	$brightFS->htmlHelper->css('@theme/plugins/fonts/octicons/octicons.min.css');
	$brightFS->htmlHelper->css('@theme/plugins/ggl/css/ggl-buttons.css');
	$brightFS->htmlHelper->css('@theme/plugins/ggl/css/ggl-dropdown.css');
	$brightFS->htmlHelper->css('@theme/plugins/select2/css/select2.css');
	$brightFS->htmlHelper->css('@theme/plugins/modal/jquery.modal.min.css');
	$brightFS->htmlHelper->css('@theme/plugins/qtip/jquery.qtip.css');

	if ( is_readable(BASEDIR.'/themes/'.$this->_theme.'tags.css') ) $brightFS->htmlHelper->css('@theme/tags.css');
	if ( $proj->prefs['custom_style'] !='' ) $brightFS->htmlHelper->css('@theme/'.$proj->prefs['custom_style']);
	
	$brightFS->htmlHelper->rss('@base/feed.php?feed_type=rss1&amp;project=' . $proj->id, 'Flyspray RSS 1.0 Feed');
	$brightFS->htmlHelper->rss('@base/feed.php?feed_type=rss2&amp;project=' . $proj->id, 'Flyspray RSS 2.0 Feed');
	$brightFS->htmlHelper->rss('@base/feed.php?feed_type=atom&amp;project=' . $proj->id, 'Flyspray Atom 3.0 Feed');

	if ( $user->isAnon() ) $brightFS->htmlHelper->css('@theme/plugins/css/login.css');

	if (isset($conf['general']['syntax_plugin']) && $conf['general']['syntax_plugin'] !='dokuwiki') {
		$brightFS->htmlHelper->css('@base/js/lightbox/css/lightbox.css');
	}
	
	$brightFS->htmlHelper->css('@theme/plugins/css/ie.css', 'all', 'IE');
	
	// Javascripts
	$brightFS->htmlHelper->script('@base/js/prototype/prototype.js');
	$brightFS->htmlHelper->script('@base/js/script.aculo.us/scriptaculous.js');

	if ( $do == 'index' || $do == 'details' ) $brightFS->htmlHelper->script('@base/js/' . $do . '.js');
	if ( $do == 'pm' || $do == 'admin' ) $brightFS->htmlHelper->script('@base/js/tablecontrol.js');
	if ( $do == 'depends' ) {
		$brightFS->htmlHelper->script('@base/js/jit/excanvas.js', 'IE');
		$brightFS->htmlHelper->script('@base/js/jit/jit.js');
	}
	
	$brightFS->htmlHelper->script('@theme/plugins/js/jquery-3.1.1.min.js');
	$brightFS->htmlHelper->scriptBlock('$.noConflict();');
	$brightFS->htmlHelper->script('@theme/plugins/select2/js/select2.js');
	$brightFS->htmlHelper->script('@theme/plugins/modal/jquery.modal.min.js');
	$brightFS->htmlHelper->script('@theme/plugins/ggl/js/ggl.js');
	$brightFS->htmlHelper->script('@theme/plugins/qtip/jquery.qtip.min.js');
	$brightFS->dokuwikiPreviewJS(Filters::noXSS(L('preview')), Filters::noXSS(L('edit')));
	$brightFS->htmlHelper->scriptBlock(<<<EOD
	jQuery(document).ready(function(){
		jQuery('.dropdown-toggle').click(function(event) {
			jQuery('.dropdown-menu').removeClass('show');
			event.stopPropagation();
			var oi = jQuery(this).data('open-id');
			jQuery('#' + oi).addClass('show');
		});
		
		function priorityIcons(priority)
		{
			if ( !priority.id ) { return priority.text; }
			return jQuery('<span class="pri' + priority.element.value + '"> <span>' + priority.element.text + '</span></span>');
		}
		
		jQuery('.s2').select2({ width: 'resolve' });
		jQuery('#priority').select2({ templateSelection: priorityIcons, templateResult: priorityIcons });
		
		
		jQuery('.hasTooltip').each(function() { 
    		jQuery(this).qtip({
    			style: { classes: 'qtip-light' },
        		content: { text: jQuery(this).next('div') },
        		overwrite: false,
        		show: { solo: true },
        		position: { 
        			//target: 'mouse'
        			 my: 'bottom center',
                	 at: 'top center'
        		}
        
        
    	}).bind('contextmenu', function(){ return false; });
	});
		
	});
	window.onclick = function(event) {
	  if (!event.target.matches('.dropdown-toggle')) {
	
		var dropdowns = document.getElementsByClassName("dropdown-menu");
		var i;
		for (i = 0; i < dropdowns.length; i++) {
		  var openDropdown = dropdowns[i];
		  if (openDropdown.classList.contains('show')) {
			openDropdown.classList.remove('show');
		  }
		}
	  }
	}
EOD
);
	
	$brightFS->htmlHelper->script('@base/js/tabs.js');
	$brightFS->htmlHelper->script('@base/js/functions.js');
	$brightFS->htmlHelper->script('@base/js/jscalendar/calendar_stripped.js');
	$brightFS->htmlHelper->script('@base/js/jscalendar/calendar-setup_stripped.js');
	$brightFS->htmlHelper->script('@base/js/jscalendar/lang/calendar-'.substr(L('locale'), 0, 2).'.js');
	$brightFS->htmlHelper->script('@base/js/lightbox/js/lightbox.js');

	if ( isset($conf['general']['syntax_plugin']) && $conf['general']['syntax_plugin'] !='dokuwiki' ) {
		$brightFS->htmlHelper->script('@base/js/ckeditor/ckeditor.js');
	}

	foreach(TextFormatter::get_javascript() as $file) $brightFS->htmlHelper->script('@base/plugins/'.$file);
?>
</head>
<body class="<?php echo (isset($do) ? Filters::noXSS($do) : 'index').' p'.$proj->id; ?>">
	<?php if (isset($_SESSION['SUCCESS']) || isset($_SESSION['ERROR']) || isset($_SESSION['ERRORS'])) { ?>
		<div id="successanderrors" onclick="this.style.display='none'">
	<?php } ?>
			
	<?php if ( isset($_SESSION['SUCCESS']) ) { ?><div class="success"><i class="fa fa-check" aria-hidden="true"></i> <?php echo Filters::noXSS($_SESSION['SUCCESS']); ?></div><?php } ?>
	<?php if ( isset($_SESSION['ERROR']) ) { ?><div class="error"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> <?php echo Filters::noXSS($_SESSION['ERROR']); ?></div><?php } ?>
	<?php if ( isset($_SESSION['ERRORS']) ) { ?>
		<?php
		foreach (array_keys($_SESSION['ERRORS']) as $e) {
			echo '<div class="error"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> '.eL($e).'</div>';
		}
		?>
	<?php } ?>
	<?php if(isset($_SESSION['SUCCESS']) || isset($_SESSION['ERROR']) || isset($_SESSION['ERRORS'])) { ?></div><?php } ?>
	<?php $brightFS->dokuwikiGeshiLanguages(); ?>
<?php $this->display('body.tpl'); ?>
