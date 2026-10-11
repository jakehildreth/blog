#!/usr/bin/env ruby
# Updates modified_date in post frontmatter based on Git history

require 'date'

def get_last_commit_date(file)
  # Get the last human commit date for this file in YYYY-MM-DD format,
  # ignoring this bot's own auto-update commits
  date_str = `git log -1 --invert-grep --grep="auto-update modified_date" --format=%cd --date=format:%Y-%m-%d -- "#{file}"`.strip
  date_str.empty? ? nil : date_str
end

def update_frontmatter(file, new_date)
  content = File.read(file)
  
  # Match frontmatter block
  if content =~ /\A---\s*\n(.*?)\n---\s*\n/m
    frontmatter = $1
    
    # Check if modified_date already exists and matches
    if frontmatter =~ /^modified_date:\s*(.+)$/
      current_date = $1.strip
      
      # Skip if already up to date
      return false if current_date == new_date
      
      # Update existing modified_date
      new_frontmatter = frontmatter.gsub(/^modified_date:.*$/, "modified_date: #{new_date}")
    else
      # Add modified_date after creation_date if it exists, otherwise at the end
      if frontmatter =~ /^creation_date:/
        new_frontmatter = frontmatter.gsub(/^(creation_date:.*)$/, "\\1\nmodified_date: #{new_date}")
      else
        # Add after title
        new_frontmatter = frontmatter.gsub(/^(title:.*)$/, "\\1\nmodified_date: #{new_date}")
      end
    end
    
    # Write updated content
    new_content = content.sub(/\A---\s*\n.*?\n---\s*\n/m, "---\n#{new_frontmatter}\n---\n")
    File.write(file, new_content)
    
    puts "✓ Updated #{file} to #{new_date}"
    return true
  else
    puts "✗ No frontmatter found in #{file}"
    return false
  end
end

def changed_files
  # Files changed in the triggering push. GITHUB_BEFORE is the SHA before the
  # push (set by the workflow); fall back to HEAD~1 for local runs.
  before = ENV['GITHUB_BEFORE'] || 'HEAD~1'
  `git diff --name-only #{before} HEAD -- _posts _drafts`.split("\n").select { |f| f.end_with?('.md') && File.exist?(f) }
end

def process_files(files)
  files.each do |file|
    last_commit_date = get_last_commit_date(file)
    
    if last_commit_date
      update_frontmatter(file, last_commit_date)
    else
      puts "⚠ No commit history found for #{file}"
    end
  end
end

# Process only files changed in the triggering push
puts "Updating modified dates based on Git history..."
puts "=" * 50

files = changed_files
if files.empty?
  puts "No changed posts to process."
else
  process_files(files)
end

puts "=" * 50
puts "Done!"
