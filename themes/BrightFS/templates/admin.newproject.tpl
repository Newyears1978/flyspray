<div id="toolbox">
  <h3><?php echo Filters::noXSS(L('createnewproject')); ?></h3>
  <?php echo tpl_form(CreateURL('admin', 'newproject')); ?>
    <div>
      <input type="hidden" name="action" value="admin.newproject" />
      <input type="hidden" name="area" value="newproject" />
    </div>
    <ul class="form_elements">
      <li>
        <label for="projecttitle"><?php echo Filters::noXSS(L('projecttitle')); ?></label>
        <input id="projecttitle" name="project_title" value="<?php echo Filters::noXSS(Req::val('project_title')); ?>" type="text" class="required text" size="40" maxlength="100" />
      </li>
      <li>
        <label for="themestyle"><?php echo Filters::noXSS(L('themestyle')); ?></label>
        <select class="s2" id="themestyle" name="theme_style">
          <?php echo tpl_options(Flyspray::listThemes(), Req::val('theme_style', $proj->prefs['theme_style']), true); ?>

        </select>
      </li>
      <li>
        <label for="langcode"><?php echo Filters::noXSS(L('language')); ?></label>
        <select class="s2" id="langcode" name="lang_code">
          <?php echo tpl_options(Flyspray::listLangs(), Req::val('lang_code', $fs->prefs['lang_code']), true); ?>
        </select>
      </li>
      <li>
        <label for="intromesg"><?php echo Filters::noXSS(L('intromessage')); ?></label>
	
		  <?php
		  require_once(BASEDIR . '/themes/BrightFS/class.BrightFS.php');
		  $brightFS = new BrightFS();
		  echo $brightFS->dokuwiki('intromesg', 'intro_message', 8, Req::val('intro_message', $proj->prefs['intro_message']), (defined('FLYSPRAY_HAS_PREVIEW') ? 'preview' : null), $baseurl);
		  ?>
      </li>
      <li>
        <label for="othersview"><?php echo Filters::noXSS(L('othersview')); ?></label>
        <?php echo tpl_checkbox('others_view', Req::val('others_view', Req::val('action') != 'admin.newproject'), 'othersview'); ?>
      </li>
      <li>
        <label for="othersviewroadmap"><?php echo Filters::noXSS(L('othersviewroadmap')); ?></label>
        <?php echo tpl_checkbox('others_viewroadmap', Req::val('others_viewroadmap', Req::val('action') != 'admin.newproject'), 'othersviewroadmap'); ?>
      </li>      
      <li>
        <label for="anonopen"><?php echo Filters::noXSS(L('allowanonopentask')); ?></label>
        <?php echo tpl_checkbox('anon_open', Req::val('anon_open'), 'anonopen'); ?>
      </li>
      <li>
         <label for="disp_intro"><?php echo Filters::noXSS(L('dispintro')); ?></label>
	 <?php echo tpl_checkbox('disp_intro', Req::val('disp_intro', 0), 'disp_intro'); ?>
     </li>
      <li>
        <td class="buttons" colspan="2"><button type="submit" class="ggl button green"><?php echo Filters::noXSS(L('createthisproject')); ?></button></td>
      </li>
    </ul>
  </form>
</div>
