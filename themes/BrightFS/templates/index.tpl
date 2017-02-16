<?php /* Start of (Check if login page requested) */ ?>
<?php if ( Req::val('login') != '1' ) { ?>
	<script type="text/javascript">
		//Used for dynamically displaying the bulk edit pane, when Checkboxes are >1
		function BulkEditCheck()
		{
			var form = document.getElementById('massops');
			var count = 0;
			for(var n=0;n < form.length;n++){
				if(form[n].name == 'ids[]' && form[n].checked){
					count++;
				}
			}
		
			if(count == 0)
			{
				Effect.Fade('bulk_edit_selectedItems',{ duration: 0.2 });
			}
			if(count == 1)
			{
				Effect.Appear('bulk_edit_selectedItems',{ duration: 0.2 });
			}
		}
	
		function massSelectBulkEditCheck()
		{
			var form = document.getElementById('massops');
			var check_count = 0, uncheck_count;
			for(var n=0;n < form.length;n++){
				if(form[n].name == 'ids[]'){
					if(form[n].checked)
						check_count++;
					else
						uncheck_count++;
				}
			}
		
			if(check_count == 0)
			{
				Effect.Appear('bulk_edit_selectedItems',{ duration: 0.2 });
			}
		
			if(uncheck_count == 0)
			{
				Effect.Fade('bulk_edit_selectedItems',{ duration: 0.2 });
			}
		}
	
		function ClearAssignments()
		{
			document.getElementById('bulk_assignment').options.length = 0;
		}
	</script>
	
	<?php /* Begin of Search */ ?>
	<?php if ( !($user->isAnon() &&  (count($fs->projects) == 0 || ($proj->id >0 && !$user->can_view_project($proj->id)))) ) { ?>
		<?php $filter = false; if ( $proj->id > 0 ) { $filter = true; $fields = explode( ' ', $proj->prefs['visible_fields'] ); } ?>
		<style type="text/css">
			#sc2,#s_searchstate{display:none;}
			#searchstateactions{color:#999;cursor:pointer;}
			#s_searchstate:checked ~ #sc2 {display:block;}
			#s_searchstate ~ label::before { content: "\25bc";}
			#s_searchstate:checked ~ label::before { content: "\25b2";}
			#blockerornoblocker {display:none;color:#c00;}
			#only_primary:checked ~ #only_blocker:checked ~ #blockerornoblocker {display:inline;}
		</style>
		<form id="search" action="<?php echo Filters::noXSS($baseurl); ?>index.php" method="get">
			<input type="hidden" name="project" value="<?php echo Filters::noXSS(Get::num('project', $proj->id)); ?>" />
			<input type="hidden" name="do" value="index" />
			
			<input class="text" id="searchtext" name="string" type="text" size="20"
				maxlength="100" placeholder="<?php echo Filters::noXSS(L('searchthisproject')); ?>"
				   value="<?php echo Filters::noXSS(Get::val('string')); ?>" accesskey="q" />
			<button class="ggl button gray" id="searchthisproject" type="submit"><?php echo Filters::noXSS(L('search')); ?></button>
			<button class="ggl button gray pull-right" type="submit" name="export_list"><?php echo Filters::noXSS(L('exporttasklist')); ?></button>
			
			<input id="s_searchstate" type="checkbox" name="advancedsearch"<?php if(Req::val('advancedsearch')): ?> checked="checked"<?php endif; ?>/>
			<label id="searchstateactions" for="s_searchstate"><?php echo Filters::noXSS(L('advanced')); ?></label>
			
			<div id="sc2" class="switchcontent">
				<?php if ( !$user->isAnon() ) { ?>
					<fieldset>
						<div class="save_search">
							<label for="save_search" id="lblsaveas"><?php echo Filters::noXSS(L('saveas'));?></label>
							<input class="text" type="text" value="<?php echo Filters::noXSS(Get::val('search_name')); ?>" id="save_search" name="search_name" size="15" />
							<button class="ggl button gray"
									onclick="savesearch('<?php echo Filters::escapeqs($_SERVER['QUERY_STRING']); ?>', '<?php echo Filters::noJsXSS($baseurl); ?>', '<?php echo Filters::noXSS(L('saving')); ?>', '<?php echo Filters::noJsXSS($_SESSION['csrftoken']); ?>')"
									type="button"><?php echo Filters::noXSS(L('OK')); ?></button>
						</div>
					</fieldset>
				<?php } ?>
				
				<fieldset class="advsearch_misc">
					<legend><?php echo Filters::noXSS(L('miscellaneous')); ?></legend>
					<?php echo tpl_checkbox('search_in_comments', Get::has('search_in_comments'), 'sic'); ?>
					<label class="left" for="sic"><?php echo Filters::noXSS(L('searchcomments')); ?></label>
					
					<?php echo tpl_checkbox('search_in_details', Get::has('search_in_details'), 'search_in_details'); ?>
					<label class="left" for="search_in_details"><?php echo Filters::noXSS(L('searchindetails')); ?></label>
					
					<?php echo tpl_checkbox('search_for_all', Get::has('search_for_all'), 'sfa'); ?>
					<label class="left" for="sfa"><?php echo Filters::noXSS(L('searchforall')); ?></label>
					
					<?php echo tpl_checkbox('only_watched', Get::has('only_watched'), 'only_watched'); ?>
					<label class="left" for="only_watched"><?php echo Filters::noXSS(L('taskswatched')); ?></label>
					
					<?php echo tpl_checkbox('only_primary', Get::has('only_primary'), 'only_primary'); ?>
					<label class="left" for="only_primary"><?php echo Filters::noXSS(L('onlyprimary')); ?></label>
					
					<?php echo tpl_checkbox('only_blocker', Get::has('only_blocker'), 'only_blocker'); ?>
					<label class="left" for="only_blocker" id="blockerlabel"><?php echo Filters::noXSS(L('onlyblocker')); ?></label>
					<span id="blockerornoblocker"><?php echo Filters::noXSS(L('blockerornoblocker')); ?></span>
	
					
					<?php echo tpl_checkbox('has_attachment', Get::has('has_attachment'), 'has_attachment'); ?>
					<label class="left" for="has_attachment"><?php echo Filters::noXSS(L('hasattachment')); ?></label>
					
					<?php echo tpl_checkbox('hide_subtasks', Get::has('hide_subtasks'), 'hide_subtasks'); ?>
					<label class="left" for="hide_subtasks"><?php echo Filters::noXSS(L('hidesubtasks')); ?></label>
				</fieldset>
				
				<fieldset class="advsearch_task">
					<legend><?php echo Filters::noXSS(L('taskproperties')); ?></legend>
					
					<!-- Task Type -->
					<div <?php if (!$filter || in_array('tasktype', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="type"><?php echo Filters::noXSS(L('tasktype')); ?></label>
						<select name="type[]" id="type" multiple="multiple" size="8">
							<?php echo tpl_options(array('' => L('alltasktypes')) + $proj->listTaskTypes(), Get::val('type', '')); ?>
						</select>
					</div>
	
					<!-- Severity -->
					<div <?php if (!$filter || in_array('severity', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="sev"><?php echo Filters::noXSS(L('severity')); ?></label>
						<select name="sev[]" id="sev" multiple="multiple" size="8">
							<?php echo tpl_options(array('' => L('allseverities')) + $fs->severities, Get::val('sev', '')); ?>
						</select>
					</div>
	
					<!-- Priority -->
					<div <?php if (!$filter || in_array('priority', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="pri"><?php echo Filters::noXSS(L('priority')); ?></label>
						<select name="pri[]" id="pri" multiple="multiple" size="8">
							<?php echo tpl_options(array('' => L('allpriorities')) + $fs->priorities, Get::val('pri', '')); ?>
						</select>
					</div>
					
					<!-- Due Version -->
					<div <?php if (!$filter || in_array('dueversion', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="due"><?php echo Filters::noXSS(L('dueversion')); ?></label>
						<select name="due[]" id="due" multiple="multiple" size="8">
							<?php echo tpl_options(array_merge(array('' => L('dueanyversion'), 0 => L('unassigned')), $proj->listVersions(false)), Get::val('due', '')); ?>
						</select>
					</div>
					
					<!-- Reportedin -->
					<div <?php if (!$filter || in_array('reportedin', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="reported"><?php echo Filters::noXSS(L('reportedversion')); ?></label>
						<select name="reported[]" id="reported" multiple="multiple" size="8">
							<?php echo tpl_options(array('' => L('anyversion')) + $proj->listVersions(false), Get::val('reported', '')); ?>
						</select>
					</div>
					
					<!-- Category -->
					<div <?php if (!$filter || in_array('category', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="cat"><?php echo Filters::noXSS(L('category')); ?></label>
						<select name="cat[]" id="cat" multiple="multiple" size="8">
							<?php echo tpl_options(array('' => L('allcategories')) + $proj->listCategories(), Get::val('cat', '')); ?>
						</select>
					</div>
					
					<!-- Status -->
					<div <?php if (!$filter || in_array('status', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="status"><?php echo Filters::noXSS(L('status')); ?></label>
						<select name="status[]" id="status" multiple="multiple" size="8">
							<?php echo tpl_options(array('' => L('allstatuses')) +
								array('open' => L('allopentasks')) +
								array('closed' => L('allclosedtasks')) +
								$proj->listTaskStatuses(), Get::val('status', '')); ?>
						</select>
					</div>
					
					<!-- Progress -->
					<div <?php if (!$filter || in_array('progress', $fields)) { echo 'class="search_select"'; } else { echo 'style="display:none"'; } ?>>
						<label class="default multisel" for="percent"><?php echo Filters::noXSS(L('percentcomplete')); ?></label>
						<?php
						# new: use of tpl_select() which provides much more control
						# maybe move some of the php code from here to scripts/index.php ...
						$selected=Get::val('percent', '');
						$selected = is_array($selected) ? $selected : (array) $selected;
						$percentages = array();
						$percentages[]=array('value'=>'', 'label'=>L('anyprogress') );
						if(in_array('', $selected, true)){
							$percentages[0]['attr']['selected']='selected';
						}
						for($i = 0; $i <= 100; $i += 10){
							$opt = array();
							$opt['value'] = $i;
							$opt['label'] = $i;
							# goes to theme.css ..
							# styling of html select options probably works only in a few browsers (at least firefox), but where it works it can be an added value.
							$opt['attr']=array('style'=>'background:linear-gradient(90deg,#0c0 0%,#0c0 '.$i.'%, #fff '.$i.'%, #fff 100%)');
							$opt['attr']=array('class'=>'percent'.$i);
							if(in_array("$i", $selected)){
								$opt['attr']['selected']='selected';
							}
							$percentages[]=$opt;
						}
						echo tpl_select(
							array(
								'name'=>'percent[]',
								'attr'=>array(
									'id'=>'percent',
									'multiple'=>'multiple',
									'size'=>12
								),
								'options'=>$percentages
							)
						);
						?>
					</div>
					<div class="clear"></div>
				</fieldset>
				
				<fieldset class="advsearch_users">
					<legend><?php echo Filters::noXSS(L('users')); ?></legend>
	
					<label class="default multisel" for="opened"><?php echo Filters::noXSS(L('openedby')); ?></label>
					<?php echo tpl_userselect('opened', Get::val('opened'), 'opened'); ?>
					
					<?php if ( !$filter || in_array('assignedto', $fields) ) { ?>
						<label class="default multisel" for="dev"><?php echo Filters::noXSS(L('assignedto')); ?></label>
						<?php echo tpl_userselect('dev', Get::val('dev'), 'dev'); ?>
					<?php } ?>
	
					<label class="default multisel" for="closed"><?php echo Filters::noXSS(L('closedby')); ?></label>
					<?php echo tpl_userselect('closed', Get::val('closed'), 'closed'); ?>
				</fieldset>
				
				<fieldset class="advsearch_dates">
					<legend><?php echo Filters::noXSS(L('dates')); ?></legend>
	
					<!-- Due Date -->
					<div <?php if (!$filter || in_array('category', $fields)) { echo 'style="clear: both;"'; } else { echo 'style="display:none"'; } ?>>
						<div class="dateselect">
							<?php echo tpl_datepicker('duedatefrom', L('selectduedatefrom')); ?>
							<?php echo tpl_datepicker('duedateto', L('selectduedateto')); ?>
						</div>
						<div class="dateselect">
							<?php echo tpl_datepicker('changedfrom', L('selectsincedatefrom')); ?>
							<?php echo tpl_datepicker('changedto', L('selectsincedateto')); ?>
						</div>
						<div class="dateselect">
							<?php echo tpl_datepicker('openedfrom', L('selectopenedfrom')); ?>
							<?php echo tpl_datepicker('openedto', L('selectopenedto')); ?>
						</div>
						<div class="dateselect">
							<?php echo tpl_datepicker('closedfrom', L('selectclosedfrom')); ?>
							<?php echo tpl_datepicker('closedto', L('selectclosedto')); ?>
						</div>
					</div>
				</fieldset>
			</div>
		</form>
	<?php } /* End Of Search */?>
	
	
	<?php /* Begin of Tasklist */ ?>
	<?php if ( isset($_GET['string']) || $total ) { ?>
		<script type="text/javascript">
			var cX = 0; var cY = 0; var rX = 0; var rY = 0;
			function UpdateCursorPosition(e){ cX = e.pageX; cY = e.pageY;}
			function UpdateCursorPositionDocAll(e){ cX = e.clientX; cY = e.clientY;}
			if(document.all) { document.onmousemove = UpdateCursorPositionDocAll; }
			else { document.onmousemove = UpdateCursorPosition; }
		</script>
		<div id="tasklist">
			<?php echo tpl_form(Filters::noXSS(CreateURL('project', $proj->id, null, $_GET)),'massops',null,null,'id="massops"'); ?>
				<div>
					<table id="tasklist_table">
						<colgroup>
							<col class="caret" />
							<?php if ( !$user->isAnon() && $proj->id !=0 && $total ) { echo '<col class="toggle" />'; };
							foreach ($visible as $col) { echo '<col class="' . $col . '" />'; }	?>
						</colgroup>
						<thead>
						<tr>
							<th class="caret"></th>
							<?php if ( !$user->isAnon() && $proj->id !=0 && $total ) {?>
								<th class="ttcolumn"><a title="<?php echo Filters::noXSS(L('toggleselected')); ?>" href="javascript:ToggleSelected('massops')" onclick="massSelectBulkEditCheck();"></a></th>
							<?php } ?>
							<?php foreach ($visible as $col) { echo tpl_list_heading($col, "<th%s>%s</th>"); } ?>
						</tr>
						</thead>
						<tbody>
						<?php foreach ($tasks as $task) { ?>
							<tr id="task<?php echo $task['task_id']; ?>" class="severity<?php echo $task['task_severity'];  echo $task['is_closed'] ==1 ? ' closed': '';?>">
								<td class="caret"></td>
								<?php if ( !$user->isAnon() && $proj->id !=0 && $total ) { ?>
									<td class="ttcolumn"><input class="ticktask" type="checkbox" name="ids[]" onclick="BulkEditCheck()" value="<?php echo $task['task_id']; ?>"/></td>
								<?php } ?>
								<?php
								foreach ($visible as $col)
								{
									if ( $col == 'tasktype' ) {
										$tasktype_class_name = '';
										if ( strpos(strtolower($task['tasktype_name']), 'bug') !== false ) $tasktype_class_name = 'bug_type';
										elseif ( strpos(strtolower($task['tasktype_name']), 'feature') !== false ) $tasktype_class_name = 'feature_type';
										elseif ( strpos(strtolower($task['tasktype_name']), 'task') !== false ) $tasktype_class_name = 'task_type';
										elseif ( strpos(strtolower($task['tasktype_name']), 'security') !== false ) $tasktype_class_name = 'security_type';
										elseif ( strpos(strtolower($task['tasktype_name']), 'performance') !== false ) $tasktype_class_name = 'performance_type';
										elseif ( strpos(strtolower($task['tasktype_name']), 'exception') !== false ) $tasktype_class_name = 'exception_type';
										elseif ( strpos(strtolower($task['tasktype_name']), 'usability') !== false ) $tasktype_class_name = 'usability_type';
										echo tpl_draw_cell($task, $col, "<td class=\"%s\"><span class=\"$tasktype_class_name\">%s</span></td>");
									}
									elseif ( $col == 'priority' ) { echo tpl_draw_cell($task, $col, "<td class=\"%s\"><span> %s</span></td>"); }
									elseif ( $col == 'progress' ) { ?>
										<td class="task_progress"><div class="progress_bar_container"><span><?php echo $task['percent_complete']; ?>%</span><div class="progress_bar" style="width:<?php echo $task['percent_complete']; ?>%"></div></div></td>
									<?php }
									elseif ($col == 'summary') {
										$summary_cell = '<td class="%s">';
										$summary_cell .= "<div class=\"hasTooltip\">%s</div>";
										$summary_cell .= '<div class="hide">';
										$summary_cell .= '<strong>' . $task['item_summary'] . '</strong>';
										$summary_cell .= $task['detailed_desc'] ? TextFormatter::render($task['detailed_desc'], 'task', $task['task_id'], $task['desccache']) : '<p>'.L('notaskdescription').'</p>';
										$summary_cell .= '</div>';
										$summary_cell .= '</td>';
										echo tpl_draw_cell($task, $col, $summary_cell);
									}
									elseif ( $col == 'status' ) {
										$status_class_name = 'caption caption-' . preg_replace('/[^a-zA-Z]+/', '', strtolower($task['status_name'])) . ' caption-invert';
										echo tpl_draw_cell($task, $col, "<td class=\"%s\"><span class=\"$status_class_name\">%s</span></td>");
									}
									else { echo tpl_draw_cell($task, $col); }
								}
								?>
							</tr>
						<?php } // End foreach task ?>
						</tbody>
					</table>
					
					<table id="pagenumbers">
						<tr>
							<?php if ($total) { ?>
								<td id="taskrange"><?php echo sprintf(L('taskrange'), $offset + 1, ($offset + $perpage > $total ? $total : $offset + $perpage), $total); ?></td>
								<td id="numbers"><?php echo pagenums($pagenum, $perpage, $total); ?></td>
							<?php } else { ?>
								<td id="taskrange"><strong><?php echo Filters::noXSS(L('noresults')); ?></strong></td>
							<?php } ?>
						</tr>
					</table>
					
					<?php /* Start Of Bulk editing Tasks */ ?>
					<?php if (!$user->isAnon() && $proj->id !=0 && $total) { ?>
						<!-- Grab fields wanted for this project so we only show those specified in the settings -->
						<div id="bulk_edit_selectedItems" style="display:none">
							<input type="hidden" name="action" value="task.bulkupdate" />
							<input type="hidden" name="user_id" value="<?php echo Filters::noXSS($user->id); ?>"/>
							<fieldset>
								<legend><b><?php echo Filters::noXSS(L('updateselectedtasks')); ?></b></legend>
								
								<ul class="form_elements slim">
								
									<!-- Quick Actions -->
									<li>
										<label for="bulk_quick_action"><?php echo Filters::noXSS(L('quickaction')); ?></label>
										<select class="s2" name="bulk_quick_action" id="bulk_quick_action">
											<option value="0"><?php echo Filters::noXSS(L('notspecified')); ?></option>
											<option value="bulk_start_watching"><?php echo Filters::noXSS(L('watchtasks')); ?></option>
											<option value="bulk_stop_watching"><?php echo Filters::noXSS(L('stopwatchingtasks')); ?></option>
											<option value="bulk_take_ownership"><?php echo Filters::noXSS(L('assigntaskstome')); ?></option>
										</select>
									</li>
	
									<!-- Status -->
									<li <?php if ( !in_array('status', $fields) ) { echo 'style="display:none"'; } ?>>
										<label for="bulk_status"><?php echo Filters::noXSS(L('status')); ?></label>
										<select class="s2" id="bulk_status" name="bulk_status">
											<?php $statusList = $proj->ListTaskStatuses(); ?>
											<?php array_unshift($statusList,L('notspecified')); ?>
											<?php echo tpl_options($statusList); ?>
										</select>
									</li>
									
									<!-- Progress -->
									<li <?php if ( !in_array('progress', $fields) ) { echo 'style="display:none"'; } ?>>
										<label for="bulk_percent"><?php echo Filters::noXSS(L('percentcomplete')); ?></label>
										<select class="s2" id="bulk_percent" name="bulk_percent_complete">
											<?php $percentCompleteList = array();$percentCompleteList[0]=L('notspecified'); for ($i = 1; $i<=101; $i+=10) $percentCompleteList[$i-1] =''.($i-1).'%'; ?>
											<?php echo tpl_options($percentCompleteList); ?>
										</select>
									</li>
									
									<!-- Task Type -->
									<li <?php if ( !in_array('tasktype', $fields) ) { echo 'style="display:none"'; } ?>>
										<?php $taskTypeList = $proj->listTaskTypes(); ?>
										<?php array_unshift($taskTypeList,L('notspecified')); ?>
										<label for="bulk_tasktype"><?php echo Filters::noXSS(L('tasktype')); ?></label>
										<select class="s2" id="bulk_tasktype" name="bulk_task_type">
											<?php echo tpl_options($taskTypeList); ?>
										</select>
									</li>
									
									<!-- Category -->
									<li <?php if ( !in_array('category', $fields) ) { echo 'style="display:none"'; } ?>>
										<?php $categoryTypeList = $proj->listCategories(); ?>
										<?php array_unshift($categoryTypeList,L('notspecified')); ?>
										<label for="bulk_category"><?php echo Filters::noXSS(L('category')); ?></label>
										<select class="s2" id="bulk_category" name="bulk_category">
											<?php echo tpl_options($categoryTypeList); ?>
										</select>
									</li>
						
									<?php if ( $user->perms('edit_assignments') ) { ?>
										<!-- Assigned To -->
										<li>
											<label for="bulk_assignment"><?php echo Filters::noXSS(L('assignedto')); ?></label>
											<?php
											//insert a noone into the list in order to bulk de-assign tasks
											$noone[0]=array(0,L('noone'));
											array_unshift($userlist,$noone);
											?>
											<select size="8" style="height: 200px;" name="bulk_assignment[]" id="bulk_assignment" multiple="multiple">
												<?php foreach ($userlist as $group => $users): ?>
												<optgroup <?php if($group == '0'){ ?> label='<?php echo eL('pleaseselect'); ?>... ' <?php } else { ?> label='<?php echo Filters::noXSS($group); ?>' <?php } ?> >
												<?php foreach ($users as $info): ?>
												<option value="<?php echo Filters::noXSS($info[0]); ?>"><?php echo Filters::noXSS($info[1]); ?></option>
												<?php endforeach; ?>
												</optgroup>
												<?php endforeach; ?>
											</select>
										</li>
									<?php } ?>
									
									<!-- OS -->
									<li <?php if ( !in_array('os', $fields) ) { echo 'style="display:none"'; } ?>>
										<?php $osTypeList = $proj->listOs(); ?>
										<?php array_unshift($osTypeList,L('notspecified')); ?>
										<label for="bulk_os"><?php echo Filters::noXSS(L('operatingsystem')); ?></label>
										<select class="s2" id="bulk_os" name="bulk_os">
											<?php echo tpl_options($osTypeList); ?>
										</select>
									</li>
									
									<!-- Severity -->
									<li <?php if ( !in_array('severity', $fields) ) { echo 'style="display:none"'; } ?>>
										<?php $severityTypeList = array_reverse($fs->severities); ?>
										<?php array_unshift($severityTypeList,L('notspecified')); ?>
										<label for="bulk_severity"><?php echo Filters::noXSS(L('severity')); ?></label>
										<select class="s2" id="bulk_severity" name="bulk_severity">
											<?php echo tpl_options($severityTypeList); ?>
										</select>
									</li>
									
									<!-- Priority -->
									<li <?php if ( !in_array('priority', $fields) ) { echo 'style="display:none"'; } ?>>
										<?php $priorityTypeList = array_reverse($fs->priorities); ?>
										<?php array_unshift($priorityTypeList,L('notspecified')); ?>
										<label for="bulk_priority"><?php echo Filters::noXSS(L('priority')); ?></label>
										<select class="s2" id="bulk_priority" name="bulk_priority">
											<?php echo tpl_options($priorityTypeList); ?>
										</select>
									</li>
									
									<!-- Reported In -->
									<li <?php if ( !in_array('reportedin', $fields) ) { echo 'style="display:none"'; } ?>>
										<?php $reportedVerList = $proj->listVersions(); ?>
										<?php array_unshift($reportedVerList,L('notspecified')); ?>
										<label for="bulk_reportedver"><?php echo Filters::noXSS(L('reportedversion')); ?></label>
										<select class="s2" id="bulk_reportedver" name="bulk_reportedver">
											<?php echo tpl_options($reportedVerList); ?>
										</select>
									</li>
									
									<!-- Due -->
									<li <?php if ( !in_array('dueversion', $fields) ) { echo 'style="display:none"'; } ?>>
										<?php $dueInVerList = $proj->listVersions(); ?>
										<?php array_unshift($dueInVerList,L('undecided')); ?>
										<?php array_unshift($dueInVerList,L('notspecified')); ?>
										<label for="bulk_dueversion"><?php echo Filters::noXSS(L('dueinversion')); ?></label>
										<select class="s2" id="bulk_dueversion" name="bulk_due_version">
											<?php echo tpl_options($dueInVerList); ?>
										</select>
									</li>
									
									<!-- Due Date -->
									<li <?php if ( !in_array('duedate', $fields) ) { echo 'style="display:none"'; } ?>>
										<label for="bulk_due_date"><?php echo Filters::noXSS(L('duedate')); ?></label>
										<?php echo tpl_datepicker('bulk_due_date'); ?>
									</li>
									
									<!-- Projects -->
									<?php // If there is only one choice of project, then don't bother showing it ?>
									<li <?php if ( count($fs->projects) <= 1 ) { echo 'style="display:none"'; } ?>>
										<?php $projectsList = $fs->listProjects(); ?>
										<?php array_unshift($projectsList,L('notspecified')); ?>
										<label for="bulk_projects"><?php echo Filters::noXSS(L('attachedtoproject')); ?></label>
										<select class="s2" id="bulk_projects" name="bulk_projects">
											<?php echo tpl_options($projectsList); ?>
										</select>
									</li>
									
								</ul>
								<button class="ggl button blue" type="submit" name="updateselectedtasks" value="true"><?php echo Filters::noXSS(L('updateselectedtasks')); ?></button>
							</fieldset>
							
							<fieldset>
								<legend><b><?php echo L('closeselectedtasks'); ?></b></legend>
								
								<div>
									<select class="s2" name="resolution_reason" onmouseup="event.stopPropagation();">
										<option value="0"><?php echo Filters::noXSS(L('selectareason')); ?></option>
										<?php echo tpl_options($proj->listResolutions(), Req::val('resolution_reason')); ?>
									</select>
									<button class="ggl button green" type="submit" name="updateselectedtasks" value="false"><?php echo L('closetasks'); ?></button>
									<br />
									<label class="default text" for="closure_comment"><?php echo Filters::noXSS(L('closurecomment')); ?></label>
									<textarea class="text" id="closure_comment" name="closure_comment" rows="3"
											  cols="25"><?php echo Filters::noXSS(Req::val('closure_comment')); ?></textarea>
									<label><?php echo tpl_checkbox('mark100', Req::val('mark100', !(Req::val('action') == 'details.close'))); ?>&nbsp;&nbsp;<?php echo Filters::noXSS(L('mark100')); ?></label>
								</div>
							</fieldset>
						</div>
					<?php } /* End Of Bulk editing Tasks */ ?>
				</div>
			<?php echo '</form>'; ?>
		</div>
	<?php } /* End Of Tasklist */ ?>
<?php } /* End of (Check if login page requested) */ ?>
