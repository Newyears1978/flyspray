<?php
require_once(BASEDIR . '/themes/BrightFS/class.BrightFS.php');
$brightFS = new BrightFS();
?><div id="toolbox">
<h3><?php echo Filters::noXSS($proj->prefs['project_title']); ?> : <?php echo Filters::noXSS(L('preferences')); ?></h3>
<?php echo tpl_form(CreateUrl('pm', 'prefs', $proj->id)); ?>
  <ul id="submenu">
   <li><a href="#general"><?php echo Filters::noXSS(L('general')); ?></a></li>
   <li><a href="#lookandfeel"><?php echo Filters::noXSS(L('lookandfeel')); ?></a></li>
   <li><a href="#notifications"><?php echo Filters::noXSS(L('notifications')); ?></a></li>
   <li><a href="#feeds"><?php echo Filters::noXSS(L('feeds')); ?></a></li>
   <li><a href="#effort"><?php echo Filters::noXSS(L('efforttracking')); ?></a></li>
  </ul>

  <div id="general" class="tab">
    <ul class="form_elements wide">
      <li>
        <label for="projecttitle"><?php echo Filters::noXSS(L('projecttitle')); ?></label>
        <input id="projecttitle" name="project_title" class="text" type="text" maxlength="100"
          value="<?php echo Filters::noXSS(Post::val('project_title', $proj->prefs['project_title'])); ?>" />
      </li>

      <li>
        <label for="defaultcatowner"><?php echo Filters::noXSS(L('defaultcatowner')); ?></label>
        <?php echo tpl_userselect('default_cat_owner', Post::val('default_cat_owner', $proj->prefs['default_cat_owner']), 'defaultcatowner'); ?>
      </li>

      <li>
        <label for="langcode"><?php echo Filters::noXSS(L('language')); ?></label>
          <select class="s2" id="langcode" name="lang_code">
            <?php echo tpl_options(Flyspray::listLangs(), Post::val('lang_code', $proj->prefs['lang_code']), true); ?>
          </select>
      </li>
      
      <?php echo tpl_checkbox('disp_intro', Post::val('disp_intro', $proj->prefs['disp_intro']), 'disp_intro'); ?>
      <label for="disp_intro"><?php echo Filters::noXSS(L('dispintro')); ?></label>
      <li class="disp_introdep">
        <label class="labeltextarea" for="intromesg"><?php echo Filters::noXSS(L('intromessage')); ?></label>
		  
        <?php
		echo $brightFS->dokuwiki('intro_message', 'intro_message', 8, Post::val('intro_message', $proj->prefs['intro_message']), (defined('FLYSPRAY_HAS_PREVIEW') ? 'preview' : null), $baseurl);
		?>
		  
        <label class="labeltextarea"><?php echo Filters::noXSS(L('pagesintromsg')); ?></label>
        <?php
          $pages = array(
            'index' => L('tasklist'),
            'toplevel' => L('toplevel'),
            'newmultitasks' => L('addmultipletasks'),
            'details' => L('details'),
            'roadmap' => L('roadmap'),
            'newtask' => L('newtask'),
            'reports' => L('reports'),
            'depends' => L('dependencygraph'),
            'pm' => L('manageproject'));
          $selectedPages = explode(' ', $proj->prefs['pages_intro_msg']);
          echo tpl_double_select('pages_intro_msg', $pages, $selectedPages, false, false);
        ?>
      </li>

      <li>
          <label class="labeltextarea" for="default_task"><?php echo Filters::noXSS(L('defaulttask')); ?></label>
		  <?php
		  echo $brightFS->dokuwiki('default_task', 'default_task', 8, Post::val('default_task', $proj->prefs['default_task']), (defined('FLYSPRAY_HAS_PREVIEW') ? 'preview_taskdesc' : null), $baseurl);
		  ?>
      </li>

      <li>
          <label for="isactive"><?php echo Filters::noXSS(L('isactive')); ?></label>
		  <?php echo tpl_checkbox('project_is_active', Post::val('project_is_active', $proj->prefs['project_is_active']), 'isactive'); ?>
      </li>

      <li>
          <label><?php echo Filters::noXSS(L('deleteproject')); ?></label>
		  <?php echo tpl_checkbox('delete_project', null); ?>
          <select class="s2" style="width: 200px" name="move_to"><?php echo tpl_options(array_merge(array(0 => L('none')), Flyspray::listProjects()), null, false, null, (string) $proj->id); ?></select>
      </li>
      
      <li>
          <label for="othersviewroadmap"><?php echo Filters::noXSS(L('othersviewroadmap')); ?></label>
		  <?php
		  # note for FS1.0: This setting is currently also used as anon/public permission for: show project name, activity, stats, milestone progress
		  # but not listing tasks per milestone
		  echo tpl_checkbox('others_viewroadmap', Post::val('others_viewroadmap', $proj->prefs['others_viewroadmap']), 'othersviewroadmap'); ?>
      </li>
      
      <li>
          <label for="othersview"><?php echo Filters::noXSS(L('othersview')); ?></label>
		  <?php
		  # note for FS1.0: This setting is current anon/public task view permission for: listing tasks (toplevel, tasklist, roadmap, RSS feed, ..)
		  echo tpl_checkbox('others_view', Post::val('others_view', $proj->prefs['others_view']), 'othersview'); ?>
      </li>

      <li>
          <label for="anon_open"><?php echo Filters::noXSS(L('allowanonopentask')); ?></label>
		  <?php echo tpl_checkbox('anon_open', Post::val('anon_open', $proj->prefs['anon_open']), 'anon_open'); ?>
      </li>

      <li>
	  	  <label for="comment_closed"><?php echo Filters::noXSS(L('allowclosedcomments')); ?></label>
		  <?php echo tpl_checkbox('comment_closed', Post::val('comment_closed', $proj->prefs['comment_closed']), 'comment_closed'); ?>
      </li>

      <li>
        <label for="auto_assign"><?php echo Filters::noXSS(L('autoassign')); ?></label>
		<?php echo tpl_checkbox('auto_assign', Post::val('auto_assign', $proj->prefs['auto_assign']), 'auto_assign'); ?>
      </li>

      <li>
        <label for="freetagging"><?php echo Filters::noXSS(L('freetagging')); ?></label>
		<?php echo tpl_checkbox('freetagging', Post::val('freetagging', $proj->prefs['freetagging']), 'freetagging'); ?>
      </li>

      <li>
        <label for="defaultdueversion"><?php echo Filters::noXSS(L('defaultdueinversion')); ?></label>
        <select class="s2" style="width: 200px" id="defaultdueversion" name="default_due_version">
          <option value="0"><?php echo Filters::noXSS(L('undecided')); ?></option>
		  <?php echo tpl_options($proj->listVersions(false, 3), Post::val('default_due_version', $proj->prefs['default_due_version']), true); ?>
        </select>
      </li>
		
    </ul>
  </div>

  <div id="lookandfeel" class="tab">
    <ul class="form_elements wide">
      <li>
        <label for="themestyle"><?php echo Filters::noXSS(L('themestyle')); ?></label>
        <select class="s2" id="themestyle" name="theme_style">
          <?php echo tpl_options(Flyspray::listThemes(), Post::val('theme_style', $proj->prefs['theme_style']), true); ?>
        </select>
        <label for="customstyle" style="width:auto"><?php echo Filters::noXSS(L('customstyle')); ?></label>
        <select class="s2" id="customstyle" name="custom_style">
        <?php
        $customs[]=array('', L('no'));
        $customstyles=glob_compat(BASEDIR ."/themes/".($proj->prefs['theme_style'])."/custom_*.css");
        foreach ($customstyles as $cs){
          $customs[]=array($cs,$cs);
        }
        echo tpl_options($customs, $proj->prefs['custom_style']);
        ?>
        </select>
      </li>

      <li>
        <label for="default_entry"><?php echo Filters::noXSS(L('defaultentry')); ?></label>
        <select class="s2" id="default_entry" name="default_entry">
          <?php echo tpl_options(array('index' => L('tasklist'), 'toplevel' => L('toplevel'), 'roadmap' => L('roadmap')), Post::val('default_entry', $proj->prefs['default_entry'])); ?>
        </select>
      </li>

        <?php // Set the selectable column names
          // Do NOT use real database column name here and in the next list,
          // but a term from translation table entries instead, because it's
          // also used elsewhere to draw a localized version of the name.
          // Look also at the end of function
          // tpl_draw_cell in scripts/index.php for further explanation.
          $columnnames = array(
            'id' => L('id'),
            'project' => L('project'),
            'parent' => L('parent'),
            'tasktype' => L('tasktype'),
            'category' => L('category'),
            'severity' => L('severity'),
            'priority' => L('priority'),
            'summary' => L('summary'),
            'dateopened' => L('dateopened'),
            'status' => L('status'),
            'openedby' => L('openedby'),
            'private' => L('private'),
            'assignedto' => L('assignedto'),
            'lastedit' => L('lastedit'),
            'editedby' => L('editedby'),
            'reportedin' => L('reportedin'),
            'dueversion' => L('dueversion'),
            'duedate' => L('duedate'),
            'comments' => L('comments'),
            'attachments' => L('attachments'),
            'progress' => L('progress'),
            'dateclosed' => L('dateclosed'),
            'closedby' => L('closedby'),
            'os' => L('os'),
            'votes' => L('votes'),
            'estimatedeffort' => L('estimatedeffort'),
            'effort' => L('effort'));
          $selectedcolumns = explode(' ', Post::val('visible_columns', $proj->prefs['visible_columns']));
         ?>

        <li>
          <label for="default_order_by"><?php echo Filters::noXSS(L('defaultorderby')); ?></label>
          <select class="s2" id="default_order_by" name="default_order_by">
            <?php echo tpl_options($columnnames, $proj->prefs['sorting'][0]['field'], false); ?>
          </select>
          <!-- <label><?php echo Filters::noXSS(L('defaultorderbydirection')); ?></label> -->
          <select class="s2" id="default_order_by_dir" name="default_order_by_dir">
            <?php echo tpl_options(array('asc' => L('ascending'), 'desc' => L('descending')), $proj->prefs['sorting'][0]['dir'], false); ?>
          </select>
        </li>

        <li>
          <label for="default_order_by2"><?php echo Filters::noXSS(L('defaultorderby2')); ?></label>
          <select class="s2" id="default_order_by2" name="default_order_by2">
            <?php echo tpl_options($columnnames, $proj->prefs['sorting'][1]['field'], false); ?>
          </select>
          <select class="s2" id="default_order_by_dir2" name="default_order_by_dir2">
            <?php echo tpl_options(array('asc' => L('ascending'), 'desc' => L('descending')), $proj->prefs['sorting'][1]['dir'], false); ?>
          </select>
        </li>

        <li>
          <label><?php echo Filters::noXSS(L('visiblecolumns')); ?></label>
          <?php echo tpl_double_select('visible_columns', $columnnames, $selectedcolumns, false); ?>
        </li>

        <li>
          <label><?php echo Filters::noXSS(L('visiblefields')); ?></label>
          <?php // Set the selectable field names
          $fieldnames = array(
            'parent' => L('parent'),
            'tasktype' => L('tasktype'),
            'category' => L('category'),
            'severity' => L('severity'),
            'priority' => L('priority'),
            'status' => L('status'),
            'private' => L('private'),
            'assignedto' => L('assignedto'),
            'reportedin' => L('reportedin'),
            'dueversion' => L('dueversion'),
            'duedate' => L('duedate'),
            'progress' => L('progress'),
            'os' => L('os'),
            'votes' => L('votes'));
          $selectedfields = explode(' ', Post::val('visible_fields', $proj->prefs['visible_fields']));
          ?>
          <?php echo tpl_double_select('visible_fields', $fieldnames, $selectedfields, false); ?>
        </li>
      </ul>
    </div>

  <div id="notifications" class="tab">
      <ul class="form_elements">
        <li>
          <label for="notify_subject"><?php echo Filters::noXSS(L('notifysubject')); ?></label>
          <input id="notify_subject" class="text" name="notify_subject" type="text" value="<?php echo Filters::noXSS(Post::val('notify_subject', $proj->prefs['notify_subject'])); ?>" />
          <br /><span class="note"><?php echo Filters::noXSS(L('notifysubjectinfo')); ?></span>
        </li>

        <li>
          <label for="emailaddress"><?php echo Filters::noXSS(L('emailaddress')); ?></label>
          <input id="emailaddress" name="notify_email" class="text" type="text" value="<?php echo Filters::noXSS(Post::val('notify_email', $proj->prefs['notify_email'])); ?>" />
        </li>

        <?php if (!empty($fs->prefs['jabber_server'])): ?>
        <li>
          <label for="jabberid"><?php echo Filters::noXSS(L('jabberid')); ?></label>
          <input id="jabberid" class="text" name="notify_jabber" type="text" value="<?php echo Filters::noXSS(Post::val('notify_jabber', $proj->prefs['notify_jabber'])); ?>" />
        </li>
        <?php endif ?>

        <li>
          <label for="notify_reply"><?php echo Filters::noXSS(L('replyto')); ?></label>
          <input id="notify_reply" name="notify_reply" class="text" type="text" value="<?php echo Filters::noXSS(Post::val('notify_reply', $proj->prefs['notify_reply'])); ?>" />
        </li>

        <li>
          <label for="notify_types"><?php echo Filters::noXSS(L('notifytypes')); ?></label>
          <select id="notify_types" size="17" multiple="multiple" name="notify_types[]">
          <?php echo tpl_options(array(0 => L('none'),
                              NOTIFY_TASK_OPENED     => L('taskopened'),
                              NOTIFY_TASK_CHANGED    => L('pm.taskchanged'),
                              NOTIFY_TASK_CLOSED     => L('taskclosed'),
                              NOTIFY_TASK_REOPENED   => L('pm.taskreopened'),
                              NOTIFY_DEP_ADDED       => L('pm.depadded'),
                              NOTIFY_DEP_REMOVED     => L('pm.depremoved'),
                              NOTIFY_COMMENT_ADDED   => L('commentadded'),
                              NOTIFY_ATT_ADDED       => L('attachmentadded'),
                              NOTIFY_REL_ADDED       => L('relatedadded'),
                              NOTIFY_OWNERSHIP       => L('ownershiptaken'),
                              NOTIFY_PM_REQUEST      => L('pmrequest'),
                              NOTIFY_PM_DENY_REQUEST => L('pmrequestdenied'),
                              NOTIFY_NEW_ASSIGNEE    => L('newassignee'),
                              NOTIFY_REV_DEP         => L('revdepadded'),
                              NOTIFY_REV_DEP_REMOVED => L('revdepaddedremoved'),
                              NOTIFY_ADDED_ASSIGNEES => L('assigneeadded')),
                              Post::val('notify_types', Flyspray::int_explode(' ', $proj->prefs['notify_types']))); ?>
          </select>
        </li>
      </ul>
  </div>

  <div id="feeds" class="tab">
      <ul class="form_elements">
        <li>
          <label for="feed_description"><?php echo Filters::noXSS(L('feeddescription')); ?></label>
          <input id="feed_description" class="text" name="feed_description" type="text" value="<?php echo Filters::noXSS(Post::val('feed_description', $proj->prefs['feed_description'])); ?>" />
        </li>

        <li>
          <label for="feed_img_url"><?php echo Filters::noXSS(L('feedimgurl')); ?></label>
          <input id="feed_img_url" class="text" name="feed_img_url" type="text" value="<?php echo Filters::noXSS(Post::val('feed_img_url', $proj->prefs['feed_img_url'])); ?>" />
        </li>
      </ul>
    </div>

  <div id="effort" class="tab">
      <ul class="form_elements">
          <li>
              <label for="useeffort"><?php echo Filters::noXSS(L('useeffort')); ?></label>
              <?php echo tpl_checkbox('use_effort_tracking', Post::val('use_effort_tracking', $proj->prefs['use_effort_tracking']), 'useeffort'); ?>
          </li>
          <li>
              <label for="hours_per_manday"><?php echo Filters::noXSS(L('hourspermanday')); ?></label>
              <input id="hours_per_manday" class="text" name="hours_per_manday" type="text"
                     value="<?php
                     $seconds = Post::val('hours_per_manday', $proj->prefs['hours_per_manday']);
                     // Post::val is in HH:mm format, $proj->prefs in seconds.
                     if (!preg_match('/^\d+$/', $seconds)) {
                        $seconds = effort::EditStringToSeconds($seconds, $proj->prefs['hours_per_manday'], effort::FORMAT_HOURS_COLON_MINUTES);
                     }

                    echo Filters::noXSS(effort::SecondsToEditString($seconds,$proj->prefs['hours_per_manday'], effort::FORMAT_HOURS_COLON_MINUTES));
                    ?>" />
          </li>
        <li>
          <label for="estimated_effort_format"><?php echo Filters::noXSS(L('estimatedeffortformat')); ?></label>
          <select class="s2" id="estimated_effort_format" name="estimated_effort_format">
            <?php echo tpl_options(array(
            effort::FORMAT_HOURS_COLON_MINUTES => L('hourplural') . ':' . L('minuteplural'),
            effort::FORMAT_HOURS_SPACE_MINUTES => L('hourplural') . ' ' . L('minuteplural'),
            effort::FORMAT_HOURS_PLAIN => L('hourplural'),
            effort::FORMAT_HOURS_ONE_DECIMAL => L('hourplural') . ' (' . L('onedecimal') . ')',
            effort::FORMAT_MINUTES => L('minuteplural'),
            effort::FORMAT_DAYS_PLAIN => L('mandays'),
            effort::FORMAT_DAYS_ONE_DECIMAL => L('mandays') . ' (' . L('onedecimal') . ')',
            effort::FORMAT_DAYS_PLAIN_HOURS_PLAIN => L('mandays') . ' ' . L('hourplural'),
            effort::FORMAT_DAYS_PLAIN_HOURS_ONE_DECIMAL => L('mandays') . ' ' . L('hourplural') . ' (' . L('onedecimal') . ')',
            effort::FORMAT_DAYS_PLAIN_HOURS_COLON_MINUTES => L('mandays') . ' ' . L('hourplural') . ":" . L('minuteplural'),
            effort::FORMAT_DAYS_PLAIN_HOURS_SPACE_MINUTES => L('mandays') . ' ' . L('hourplural') . " " . L('minuteplural'),
            ),
            Post::val('estimated_effort_format', $proj->prefs['estimated_effort_format'])); ?>
          </select>
        </li>
        <li>
          <label for="current_effort_done_format"><?php echo Filters::noXSS(L('currenteffortdoneformat')); ?></label>
          <select class="s2" id="current_effort_done_format" name="current_effort_done_format">
            <?php echo tpl_options(array(
            effort::FORMAT_HOURS_COLON_MINUTES => L('hourplural') . ':' . L('minuteplural'),
            effort::FORMAT_HOURS_SPACE_MINUTES => L('hourplural') . ' ' . L('minuteplural'),
            effort::FORMAT_HOURS_PLAIN => L('hourplural'),
            effort::FORMAT_HOURS_ONE_DECIMAL => L('hourplural') . ' (' . L('onedecimal') . ')',
            effort::FORMAT_MINUTES => L('minuteplural'),
            effort::FORMAT_DAYS_PLAIN => L('mandays'),
            effort::FORMAT_DAYS_ONE_DECIMAL => L('mandays') . ' (' . L('onedecimal') . ')',
            effort::FORMAT_DAYS_PLAIN_HOURS_PLAIN => L('mandays') . ' ' . L('hourplural'),
            effort::FORMAT_DAYS_PLAIN_HOURS_ONE_DECIMAL => L('mandays') . ' ' . L('hourplural') . ' (' . L('onedecimal') . ')',
            effort::FORMAT_DAYS_PLAIN_HOURS_COLON_MINUTES => L('mandays') . ' ' . L('hourplural') . ":" . L('minuteplural'),
            effort::FORMAT_DAYS_PLAIN_HOURS_SPACE_MINUTES => L('mandays') . ' ' . L('hourplural') . " " . L('minuteplural'),
            ),
            Post::val('current_effort_done_format', $proj->prefs['current_effort_done_format'])); ?>
          </select>
        </li>
      </ul>
  </div>

  <div class="tbuttons">
    <input type="hidden" name="action" value="pm.updateproject" />
    <input type="hidden" name="project_id" value="<?php echo Filters::noXSS($proj->id); ?>" />
    <button type="submit" class="ggl button green"><?php echo Filters::noXSS(L('saveoptions')); ?></button>
    <button type="reset" class="ggl button gray"><?php echo Filters::noXSS(L('resetoptions')); ?></button>
  </div>
</form>
</div>