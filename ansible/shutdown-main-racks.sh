#!/bin/bash
# shutdown-main-racks.sh
# Convenience script to shutdown pi5main and nas racks in one command
# 
# Usage:
#   ./shutdown-main-racks.sh              # Normal shutdown with confirmation
#   ./shutdown-main-racks.sh --force      # Skip confirmation
#   ./shutdown-main-racks.sh --check      # Dry run only

set -e

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
FORCE=false
CHECK=false

for arg in "$@"; do
  case $arg in
    --force)
      FORCE=true
      shift
      ;;
    --check)
      CHECK=true
      shift
      ;;
    --help)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Shutdown pi5main and nas racks in one command"
      echo ""
      echo "Options:"
      echo "  --force    Skip confirmation prompt"
      echo "  --check    Dry run (show what would be shut down)"
      echo "  --help     Show this help message"
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Display banner
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  HomeRack - Shutdown Main Racks${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Show what will be shut down
echo -e "${YELLOW}📋 Racks to be shut down:${NC}"
echo "  • pi5main rack (devices: pi5main)"
echo "  • nas rack (devices: cm3588 if active)"
echo ""

if [ "$CHECK" = true ]; then
  echo -e "${YELLOW}🔍 Running in DRY RUN mode${NC}"
  echo ""
fi

# Confirmation prompt (skip if --force or --check)
if [ "$FORCE" = false ] && [ "$CHECK" = false ]; then
  echo -e "${RED}⚠️  WARNING: This will shut down all devices in pi5main and nas racks!${NC}"
  echo ""
  read -p "Do you want to continue? (yes/no): " -r
  echo ""
  
  if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo -e "${YELLOW}Shutdown cancelled.${NC}"
    exit 0
  fi
fi

# Build ansible command options
ANSIBLE_OPTS=""
if [ "$CHECK" = true ]; then
  ANSIBLE_OPTS="--check"
fi

# Shutdown pi5main rack
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🔌 Shutting down pi5main rack...${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

ansible-playbook playbooks/shutdown.yml -e target_rack=pi5main $ANSIBLE_OPTS

echo ""
echo -e "${GREEN}✅ pi5main rack shutdown complete${NC}"
echo ""

# Shutdown nas rack
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🔌 Shutting down nas rack...${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

ansible-playbook playbooks/shutdown.yml -e target_rack=nas $ANSIBLE_OPTS

echo ""
echo -e "${GREEN}✅ nas rack shutdown complete${NC}"
echo ""

# Final summary
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if [ "$CHECK" = true ]; then
  echo -e "${BLUE}  ✅ Dry run complete - no devices were shut down${NC}"
else
  echo -e "${BLUE}  ✅ All racks have been shut down successfully${NC}"
fi
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [ "$CHECK" = false ]; then
  echo -e "${YELLOW}📝 Note: Devices will power off after their configured delay${NC}"
  echo ""
fi